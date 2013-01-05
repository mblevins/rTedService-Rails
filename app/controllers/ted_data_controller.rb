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

  # GET /ted_data/1
  # GET /ted_data/1.json
  def show
    @ted_datum = TedDatum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ted_datum }
    end
  end

  # GET /ted_data/new
  # GET /ted_data/new.json
  def new
    @ted_datum = TedDatum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ted_datum }
    end
  end

  # GET /ted_data/1/edit
  def edit
    @ted_datum = TedDatum.find(params[:id])
  end

  # POST /ted_data
  # POST /ted_data.json
  def create
    @ted_datum = TedDatum.new(params[:ted_datum])

    respond_to do |format|
      if @ted_datum.save
        format.html { redirect_to @ted_datum, notice: 'Ted datum was successfully created.' }
        format.json { render json: @ted_datum, status: :created, location: @ted_datum }
      else
        format.html { render action: "new" }
        format.json { render json: @ted_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ted_data/1
  # PUT /ted_data/1.json
  def update
    @ted_datum = TedDatum.find(params[:id])

    respond_to do |format|
      if @ted_datum.update_attributes(params[:ted_datum])
        format.html { redirect_to @ted_datum, notice: 'Ted datum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ted_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ted_data/1
  # DELETE /ted_data/1.json
  def destroy
    @ted_datum = TedDatum.find(params[:id])
    @ted_datum.destroy

    respond_to do |format|
      format.html { redirect_to ted_data_url }
      format.json { head :no_content }
    end
  end
end
