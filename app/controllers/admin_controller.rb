class AdminController < ApplicationController
  
  include ApplicationHelper
  
  before_filter :authenticate_user!

  def index
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def updateday
    day = params[:day]
    if day == nil then
      @status = "Missing parameter"
    else
      @status = update_day( day )
    end
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def loadtestdata
    
    TedDatum.create( :mtu => '1052B6', :mtype => 2, :cumtime => '2013-01-02 08:00:10', :watts => 100000 )
    TedDatum.create( :mtu => '1052B6', :mtype => 2, :cumtime => '2013-01-02 08:00:20', :watts => 115000 )
    TedDatum.create( :mtu => '106248', :mtype => 2, :cumtime => '2013-01-02 08:00:10', :watts => -200000 )
    TedDatum.create( :mtu => '106248', :mtype => 2, :cumtime => '2013-01-02 08:00:20', :watts => -218000 )
    TedDatum.create( :mtu => '105BC7', :mtype => 3, :cumtime => '2013-01-02 08:00:10', :watts => 10000 )
    TedDatum.create( :mtu => '105BC7', :mtype => 3, :cumtime => '2013-01-02 08:00:30', :watts => 11000 )
    
    TedDatum.create( :mtu => '1052B6', :mtype => 2, :cumtime => '2013-01-03 08:00:10', :watts => 100000 )
    TedDatum.create( :mtu => '1052B6', :mtype => 2, :cumtime => '2013-01-03 08:00:20', :watts => 115000 )
    TedDatum.create( :mtu => '106248', :mtype => 2, :cumtime => '2013-01-03 08:00:10', :watts => -200000 )
    TedDatum.create( :mtu => '106248', :mtype => 2, :cumtime => '2013-01-03 08:00:20', :watts => -218000 )
    TedDatum.create( :mtu => '105BC7', :mtype => 3, :cumtime => '2013-01-03 08:00:10', :watts => 10000 )
    TedDatum.create( :mtu => '105BC7', :mtype => 3, :cumtime => '2013-01-03 08:00:30', :watts => 11000 )

  end
  
end
