class AdminController < ApplicationController
  
  include ApplicationHelper
  
  before_filter :authenticate_user!

  def index
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @day_hists }
    end
  end
  
  def updateday
    day = params[:day]
    if day == nil then
      flash[:notice] = "Missing parameter"
    else
      update_day( day )
    end
  end
  
  def loadtestdata
    
    TedDatum.create( :mtu => '1052B6', :mtype => 2, :cumtime => '2013-01-02 00:00:10', :watts => 100000 )
    TedDatum.create( :mtu => '1052B6', :mtype => 2, :cumtime => '2013-01-02 00:00:20', :watts => 115000 )
    TedDatum.create( :mtu => '106248', :mtype => 2, :cumtime => '2013-01-02 00:00:10', :watts => -200000 )
    TedDatum.create( :mtu => '106248', :mtype => 2, :cumtime => '2013-01-02 00:00:20', :watts => -218000 )
    TedDatum.create( :mtu => '105BC7', :mtype => 3, :cumtime => '2013-01-02 00:00:10', :watts => 10000 )
    TedDatum.create( :mtu => '105BC7', :mtype => 3, :cumtime => '2013-01-02 00:00:30', :watts => 11000 )

  end
  
end