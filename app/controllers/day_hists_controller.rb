class DayHistsController < ApplicationController
  # GET /day_hists
  # GET /day_hists.json
  def index
    DayHist.page(params[:page]).order('created_at DESC')
    @day_hists = DayHist.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @day_hists }
    end
  end

  # GET /day_hists/1
  # GET /day_hists/1.json
  def show
    @day_hist = DayHist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @day_hist }
    end
  end

  # GET /day_hists/new
  # GET /day_hists/new.json
  def new
    @day_hist = DayHist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @day_hist }
    end
  end

  # GET /day_hists/1/edit
  def edit
    @day_hist = DayHist.find(params[:id])
  end

  # POST /day_hists
  # POST /day_hists.json
  def create
    @day_hist = DayHist.new(params[:day_hist])

    respond_to do |format|
      if @day_hist.save
        format.html { redirect_to @day_hist, notice: 'Day hist was successfully created.' }
        format.json { render json: @day_hist, status: :created, location: @day_hist }
      else
        format.html { render action: "new" }
        format.json { render json: @day_hist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /day_hists/1
  # PUT /day_hists/1.json
  def update
    @day_hist = DayHist.find(params[:id])

    respond_to do |format|
      if @day_hist.update_attributes(params[:day_hist])
        format.html { redirect_to @day_hist, notice: 'Day hist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @day_hist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /day_hists/1
  # DELETE /day_hists/1.json
  def destroy
    @day_hist = DayHist.find(params[:id])
    @day_hist.destroy

    respond_to do |format|
      format.html { redirect_to day_hists_url }
      format.json { head :no_content }
    end
  end
  
 
end
