class Public::ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  def index
    @allitems = Item.where(is_active: true)
    @items = Item.where(is_active: true).page(params[:page])
    @genres = Genre.limit(10)
    @genre = Genre.find(params[:genre_id])
  end
end
