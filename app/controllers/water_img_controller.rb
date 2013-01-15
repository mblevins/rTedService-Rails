class WaterImgController < ApplicationController
  def index
    daysToDisplay = 7
    numRecords = daysToDisplay * $all_mtus.length
    dayHistsResult = DayHist.limit(numRecords).order( "day DESC" )

    if (dayHistsResult.length < numRecords)
      numRecords = dayHistsResult.length
      daysToDisplay = numRecords / 3
    end

    waterWatts = Array.new( daysToDisplay )
    dayLabel = Array.new( daysToDisplay )

    # Since we're reverse ordered, we actually do the strings backward for the graph
    dayIdx = daysToDisplay - 1
    recIdx = 0
    dayHistsResult.each do |dayHist|
      if (dayHist.mtu == $water_mtu) then
        waterWatts[dayIdx] = (dayHist.watts / 1000).to_s
      end
      dayLabel[dayIdx] = "#{dayHist.day.month}/#{dayHist.day.day}"
      recIdx = recIdx + 1
      if (recIdx == $all_mtus.length) then
        dayIdx = dayIdx - 1
        recIdx = 0
      end
    end

    # https://developers.google.com/chart/image/docs/gallery/bar_charts

      @liveGraphURL =
        "http://chart.googleapis.com/chart" +
           "\?chxl=0:|0|1|2|3|4|5|1:|#{dayLabel.join('|')}" + 
           "\&chxr=0,0,5|1,1,100" +
           "\&chxs=0,676767,11.5,0,l,676767" + 
           "\&chco=0000FF" + 
           "\&chxt=y,x" +
           "\&chbh=a,1,12" +
           "\&chs=300x225" +
           "\&cht=bvg" +
           "\&chds=0,5" +
           "\&chd=t:#{waterWatts.join(',')}"

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @ted_data }
      end
  end
end
