module DayhistUpdaterHelper
  def getTotalWattage( day, mtu ) 
    tedDatumResult = tedDatum.where("cumtime = ? and mtu = ?", day, mtu)
    watts = 0
    tedDataumResult.each do |t|
      
      case t.mtype
      when 0
        watts = watts + 1
      when 1
        watts = watts - 1
      when 2
        watts = watts + 1
      when 3
        watts = watts + 1
      when 5
        watts = watts + 1
      else
        logger.warn "unexpected m_type for #{day}, #{mtu}"
      end
    end
  end
end
