class DayhistUpdaterController < ApplicationController
  
   def autoupdate

     if params[:day] == nil then
       time = Time.now
       day = time.strftime("%Y-%m-%d")
     else
       time = Time.parse(params[:day])
     end
     day = time.strftime("%Y-%m-%d")
    
     logger.debug "day=#{day}"

     numFound=0
     numSaved=0
     numErrors=0

     $all_mtus.each do |mtu|
       logger.debug "mtu = #{mtu}"
       day_hist_result = DayHist.where("day = ? and mtu = ?", day, mtu)
       case day_hist_result.length
        when 0
          day_hist = DayHist.new do |d|
            d.day = day
            d.mtu = mtu
            d.watts = 23
          end
          if day_hist.save then
            numSaved = numSaved + 1
          else
            numErrors = numErrors + 1
          end
        when 1
         numFound = numFound + 1
       else
         logger.warn "Unexpected number of records returned for #{}{day}, #{mtu}"
         numErrors = numErrors + 1
       end
     end
     @msg = "Found=#{numFound}, Saved=#{numSaved}, Errors=#{numErrors}"

     respond_to do |format|
       format.html # show.html.erb
       # todo: make this a class for json
       format.json { render json: @msg }
     end
   end
end
