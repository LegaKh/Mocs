class OrdersController < ApplicationController
  before_action :set_order, only: [:update, :update_state]
  before_action :authorize, only: [:create, :update, :update_state]

  def index
    render json: current_user ? current_user.orders.order('created_at DESC').includes(:items) : []
  end

  def create
    @order = current_user.orders.new
    add_items
    if @order.save
      render json: @order
    else
      head status: :unprocessable_entity
    end
  end

  def update
    add_items
    render json: @order
  end

  def update_state
    @order.public_send(params[:state])
    render json: @order
  end

  private

  def add_items
    new_items = order_params['items_ids'].uniq - @order.item_ids
    if new_items.any?
      new_items.each do |item_id|
        @order.items << Item.find(item_id)
      end
    end
  end

  def set_order
    @order = current_user.orders.find(params[:id])
  end

  def order_params
    params.permit(items_ids: [])
  end
end
