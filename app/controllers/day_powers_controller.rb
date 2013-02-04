class DayPowersController < ApplicationController
  # GET /day_powers
  # GET /day_powers.json
  def index
     DayPower.page(params[:page]).order('day DESC')
     @day_powers = DayPower.paginate(:page => params[:page])

     respond_to do |format|
       format.html # index.html.erb
       format.json { render json: @day_hists }
     end 
  end

  # GET /day_powers/1
  # GET /day_powers/1.json
  def show
    @day_power = DayPower.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @day_power }
    end
  end

end
