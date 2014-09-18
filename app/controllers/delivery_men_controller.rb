class DeliveryMenController < ApplicationController
  before_action :set_delivery_man, only: [:show, :edit, :update, :destroy]

  # GET /delivery_men
  # GET /delivery_men.json
  def index
    @delivery_men = DeliveryMan.all
  end

  # GET /delivery_men/1
  # GET /delivery_men/1.json
  def show
  end

  # GET /delivery_men/new
  def new
    @delivery_man = DeliveryMan.new
  end

  # GET /delivery_men/1/edit
  def edit
  end

  # POST /delivery_men
  # POST /delivery_men.json
  def create
    @delivery_man = DeliveryMan.new(delivery_man_params)

    respond_to do |format|
      if @delivery_man.save
        format.html { redirect_to @delivery_man, notice: 'Delivery man was successfully created.' }
        format.json { render :show, status: :created, location: @delivery_man }
      else
        format.html { render :new }
        format.json { render json: @delivery_man.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /delivery_men/1
  # PATCH/PUT /delivery_men/1.json
  def update
    respond_to do |format|
      if @delivery_man.update(delivery_man_params)
        format.html { redirect_to @delivery_man, notice: 'Delivery man was successfully updated.' }
        format.json { render :show, status: :ok, location: @delivery_man }
      else
        format.html { render :edit }
        format.json { render json: @delivery_man.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delivery_men/1
  # DELETE /delivery_men/1.json
  def destroy
    @delivery_man.destroy
    respond_to do |format|
      format.html { redirect_to delivery_men_url, notice: 'Delivery man was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery_man
      @delivery_man = DeliveryMan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delivery_man_params
      params[:delivery_man]
    end
end
