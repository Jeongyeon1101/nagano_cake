class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    if params[:search]
      @items = Item.where("name LIKE ? ", '%' + params[:search] + '%')
      @items = @items.page(params[:page])
    elsif params[:genre_name]
      @items = Item.where(params[:genre_name])
      @items = @items.page(params[:page])
    else
      @items = Item.page(params[:page])
    end
  end

  def show
    @item = Item.find(params[:id])
  end

end
