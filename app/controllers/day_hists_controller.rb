class DayHistsController < ApplicationController
  # GET /day_hists
  # GET /day_hists.json
  def index
    DayHist.page(params[:page]).order('day DESC')
    @day_hists = DayHist.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @day_hists }
    end
  end
 
end
