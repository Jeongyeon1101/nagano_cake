class Public::ItemsController < ApplicationController
  def index
    if params[:search]
      @items = Item.where("name LIKE ? ", '%' + params[:search] + '%')
      @items = @items.page(params[:page])
    else
      @items = Item.page(params[:page])
    end
  end

  def show
    @item = Item.find(params[:id])
  end

end
