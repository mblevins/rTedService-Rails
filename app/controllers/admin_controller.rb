class AdminController < ApplicationController
  
before_filter :authenticate_user!

  def index
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @day_hists }
    end
  end
end
