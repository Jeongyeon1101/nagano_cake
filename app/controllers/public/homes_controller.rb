class Public::HomesController < ApplicationController
  def top
     @genres = Genre.all
    if params[:search]
      @items = Item.where("name LIKE ? ", '%' + params[:search] + '%')
      @items = @items.page(params[:page])
      @genre_name = "商品"
    elsif params[:genre_name]
      @items = Genre.find_by(name: params[:genre_name]).items
      @items = @items.page(params[:page])
      @genre_name = params[:genre_name]
    else
      @items = Item.all.first(4)
    end
  end

  def about
  end
end
