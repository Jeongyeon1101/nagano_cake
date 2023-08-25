class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items
    @total_payment = 0
    @order.shipping_cost = 800
    if params[:order][:select_address] == "registered_address"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "current_address"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    else
      @order.save
    end
    @order_new = Order.new
    render :confirm
  end

  def create
    order = Order.new(order_params)
    order.save
    @cart_items = current_customer.cart_items.all

    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = order.id
      @order_details.item_id = cart_item.item.id
      @order_details.price = cart_item.item.with_tax_price
      @order_details.amount = cart_item.amount
      @order_details.making_status = 0
      @order_details.save
    end

    CartItem.destroy_all
    redirect_to orders_complete_path
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
end
