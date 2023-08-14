class Public::ItemsController < ApplicationController
  def index
    if params[:item_name]

    else
      @items = Item.page(params[:page])
    end
  end

  def show
    @item = Item.find(params[:id])
  end

end
