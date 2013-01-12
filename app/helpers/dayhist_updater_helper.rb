module DayhistUpdaterHelper
  def getTotalWattage( day, mtu ) 
    tedDatumResult = TedDatum.where("date(cumtime) = ? and mtu = ?", day, mtu).order( :cumtime )
    
    t1 = tedDatumResult.first
    if (t1 == nil) then
      # nothing to do, but that's not an error
      logger.warn("Nothing to do for #{day} and #{mtu}")
      return 0
    end

    
    t2 = tedDatumResult.last
    
    logger.debug "t1=#{t1}, t2=#{t2}"
  
    # assume t1 and t2 are the same mtype!
    case t1.mtype  
    when 0, 2, 3, 5
     watts = t2.watts - t1.watts;
    when 1
     watts = - (t2.watts - t1.watts);
    else
     logger.warn "unexpected m_type for #{day}, #{mtu}: type=#{t.mtype}"
   end
   return watts;
  end
end


