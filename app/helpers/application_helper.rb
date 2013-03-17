module ApplicationHelper
  
  $pge_mtu = '1052B6'
  $solar_mtu = '106248'
  $water_mtu = '105BC7'
  
  $all_mtus = ['1052B6', '106248', '105BC7' ]
  
  def mtu_to_string( mtu )
    return case mtu
    when '1052B6'
      "PG&E"
    when '106248'
      "Solar"
    when '105BC7'
      "Water"
    else
      "unknown"
    end
  end
  
  def update_day( day )
    
    status = ""
    
    startTime = DateTime.strptime( "#{day}T00:00-08:00", '%Y-%m-%dT%H:%M%z' )
    endTime = startTime + 1
    
    # make sure we have complete data
    nextDay = DateTime.parse( day ) + 1
    tedDatumResult = TedDatum.where("cumtime > ?", endTime ).limit(1)
    if (tedDatumResult.length == 0) then
      status = "Not saved, data incomplete for #{day}"
      logger.debug "update_day: No TedDatum for #{endTime}"
    end
    
    # See if we have already done this
    if (status == "") then
      dpResult = DayPower.where( "day = ?", day )
      logger.debug "update_day: DayPower Fetch for #{day} is #{dpResult.length}"
      if (dpResult.length == 1) then
        status = "Not saved, day already updated"
      end
    end

  
    if (status == "") then
      
      dp = DayPower.new
      dp.day = day
      
      # if we don't set it at the end...
      status = "Something unexpected happened"
      
      $all_mtus.each do |mtu|
  
        tedDatumResult = TedDatum.where("cumtime > ? and cumtime < ? and mtu = ?", startTime, endTime, mtu).order( :cumtime )

        t1 = tedDatumResult.first
        if (t1 == nil) then
          # nothing to do, but that's not an error
          case mtu
          when $pge_mtu
            dp.pgeWatts = 0
          when $solar_mtu
            dp.solarWatts = 0
          when $water_mtu
            dp.waterWatts = 0
          else
            logger.warn "unexpected m_type for #{day}, #{mtu}: type=#{t1.mtype}"
          end
          logger.warn("Nothing to do for #{day} and #{mtu}")
        else

          t2 = tedDatumResult.last

          # assume t1 and t2 are the same mtype!
          case t1.mtype  
          when '0', '2', '3', '5'
           watts = t2.watts - t1.watts;
          when '1'
           watts = - (t2.watts - t1.watts);
          else
           logger.warn "unexpected m_type for #{day}, #{mtu}: type=#{t1.mtype}"
          end

          case mtu
          when $pge_mtu
            dp.pgeWatts = watts / 1000
          when $solar_mtu
            dp.solarWatts = watts / 1000
          when $water_mtu
            dp.waterWatts = watts / 1000
          else
            logger.warn "unexpected m_type for #{day}, #{mtu}: type=#{t1.mtype}"
          end
        end
      end
      if (dp.save) then
        status = "Saved day #{day}"
        logger.debug "Update_day: Day #{day} saved"
      else
        status = "Save failed for day #{day}"
        logger.warn "Can't save day #{day}"
      end
    end
    return status
  end
   
end
