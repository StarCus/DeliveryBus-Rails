class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :assign]

  # GET /orders
  # GET /orders.json
  def index
    @user = current_user
    @orders = @user.orders.order("created_at DESC")
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.user = current_user

    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_path, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /orders/assign
  def assign
    @order.delivery_man = current_user.delivery_man
    if @order.save
      respond_to do |format|
        format.html { redirect_to @order, notice: "Successed" }
        format.json { render :show, status: :ok, location: @order }
      end
    else
      respond_to do |format|
        format.html { redirect_to @order, notice: "Error" }
        format.json { render :show, status: :ok, location: @order }
      end
    end      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params[:order].permit(:address, :amount, :price, :payment_method)
    end
end
