class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    if params[:customer_id]
      @orders = Customer.find_by(id: params[:customer_id]).orders
      @order = @orders.each do |order|
        @order_details = order.order_details
      end
      @order_details = @order_details.page(params[:page]).per(10)
      @customer = Customer.find_by(id: params[:customer_id])
    else
      @order_details = OrderDetail.page(params[:page]).per(10)
    end
  end
end
