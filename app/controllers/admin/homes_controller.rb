class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    if params[:customer_id]
      @customer = Customer.find(params[:customer_id])
      @orders = @customer.orders.page(params[:page])
      #@orders = Customer.find_by(id: params[:customer_id]).orders
      #@orders.each do |order|
        #@order_details = order.order_details
      #end
      #@order_details = @order_details.page(params[:page])
      #@customer = Customer.find_by(id: params[:customer_id])
    else
      @orders = Order.page(params[:page])
    end
  end
end
