class PowerGraphController < ApplicationController
  def index
      
    @graphType = params[:graphType]
    if (@graphType == nil) then
      @graphType = "bar"
    end
    
    if (@graphType == "time")
      limit = 365
    elsif (@graphType == "table")
      limit = 30
    else
      # sleazy...
      @graphType = "bar"
      limit = 7
    end
    
    @dayPowersResult = DayPower.limit(limit).order( "day DESC" )
    
    render :template => 'power_graph/index.html.erb'
  end

  def show
  end
end
