class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    if params[:customer_id]
      @order_details = Customer.find_by(id: params[:customer_id]).orders
      @order_details = @order_details.each do |order|
      @order_details = @order_details.order_details  
      @order_details = @order_details.page(params[:page])
      @customer = Customer.find(params[:id])
    else
      @order_details = OrderDetail.page(params[:page])
    end
  end
end
