class OrdersController < ApplicationController

  def index
    render json: current_user.orders.to_json(include: { items: {
                                                       except: [:created_at, :updated_at] }
                                                      })
  end

  def create
    order = current_user.orders.new
    add_items_to(order)
    if order.save
      head :ok
    else
      head status: :unprocessable_entity
    end
  end

  def update
    order = current_user.orders.find(params[:id])
    add_items_to(order)
    render json: order
  end

  private

  def add_items_to(order)
    new_items = order_params['items_ids'].uniq - order.item_ids
    if new_items.any?
      new_items.each do |item_id|
        order.items << Item.find(item_id)
      end
    end
  end

  def order_params
    params.permit(items_ids: [])
  end
end
