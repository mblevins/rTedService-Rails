class TedDataController < ApplicationController
  # GET /ted_data
  # GET /ted_data.json
  def index
    TedDatum.page(params[:page]).order('created_at DESC')
    @ted_data = TedDatum.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ted_data }
    end
  end
end
