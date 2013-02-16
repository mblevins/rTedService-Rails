class PowerGraphController < ApplicationController
  def index
      @dayPowersResult = DayPower.limit(365).order( "day DESC" )
      
    @graphType = params[:graphType]
    if (@graphType == nil) then
      @graphType = "bar"
    elsif (@graphType != "time" and @graphType != "bar" and @graphType != "table")
      # sleazy...
      @graphType = "bar"
    end
    
    render :template => 'power_graph/index.html.erb'
  end

  def show
  end
end
