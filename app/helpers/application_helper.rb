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
    
    found = false;
    begin
      DayPower.find( day )
      found = true
    rescue ActiveRecord::RecordNotFound 
      logger.debug "Day not found"
    end
    
    if (!found)
     
      dp = DayPower.new
      dp.day = day
      
      $all_mtus.each do |mtu|
    
        tedDatumResult = TedDatum.where("date(cumtime) = ? and mtu = ?", day, mtu).order( :cumtime )

        t1 = tedDatumResult.first
        if (t1 == nil) then
          # nothing to do, but that's not an error
          logger.warn("Nothing to do for #{day} and #{mtu}")
          dp.pgeWatts = 0
          dp.solarWatts = 0
          dp.waterWatts = 0
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
      if (!dp.save) then
        logger.warn "Can't save day"
      end
    end
  end
   
end
