class Public::ItemsController < ApplicationController
  
  before_action :authenticate_customer!

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end

  def index
    @allitems = Item.where(is_active: true)
    # @items = Item.where(is_active: true).page(params[:page])
    @genres = Genre.all

    @q = Item.ransack(params[:q])

    if params[:q].present?
      # 検索がある場合
      @items = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
      @allitems = @q.result(distinct: true)
    else
      # 検索がない場合（通常の一覧）
      @items = Item.where(is_active: true).order(created_at: :desc).page(params[:page])
      @allitems = Item.where(is_active: true)
    end
  end
end
