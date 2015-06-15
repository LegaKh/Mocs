class OrdersController < ApplicationController

  def index
    render json: current_user.orders
  end

  def create
    binding.pry
    order = current_user.orders.new(order_params)
    if order.save
      head :ok
    else
      head status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(items_attributes: :id)
  end
end
