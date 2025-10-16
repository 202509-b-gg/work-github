class Public::ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
  end

  def index
    @allitems = Item.all
    @items = Item.page(params[:page])
  end
end
