module ApplicationHelper
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
    
end
