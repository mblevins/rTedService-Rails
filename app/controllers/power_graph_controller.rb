class PowerGraphController < ApplicationController
  def index
      @dayPowersResult = DayPower.limit(365).order( "day DESC" )
      
    render :template => 'power_graph/index.html.erb'
  end

  def show
  end
end
