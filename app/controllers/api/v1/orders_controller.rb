class Api::V1::OrdersController < Api::V1::ApiController

  # GET /api/v1/index
  def index
    orders = current_delivery_man.get_current_orders
    render json: orders
  end

  # PUT /api/v1/orders/:id
  def update
    order = Order.find(order_params[:id])
    if order.update_attributes(order_params)
      render json: {
        code: "SUCCESS"
      }
    end
  end

  private 
  def order_params
    params[:order].permit(:id, :status)
  end

end