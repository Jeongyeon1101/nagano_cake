class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def create
    if CartItem.find_by(item_id: params[:item_id])
      @cart_item = current_customer.cart_items.find_by(item_id: params[:item_id])
      @cart_item.customer_id = current_customer.id
      @cart_item.item_id = @cart_item.item.id
      @cart_item.amount = @cart_item.amount + params[:amount]
      @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      @cart_item.item_id = @cart_item.item.id
      @cart_item.save
      redirect_to cart_items_path
    end
  end

  def index
    @cart_items = current_customer.cart_items
    @total = 0
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
