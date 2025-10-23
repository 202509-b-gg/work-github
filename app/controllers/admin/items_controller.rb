class Admin::ItemsController < ApplicationController
  # ログイン必須
  before_action :authenticate_admin!

  def index
    @items=Item.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "新しい商品を登録しました。"
      redirect_to admin_item_path(@item)
    else
      @genres = Genre.all
      flash.now[:alert] = "商品の登録に失敗しました。"
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "商品情報を更新しました。"
      redirect_to admin_item_path(@item)
    else
      flash.now[:alert] = "商品情報の更新に失敗しました。"
      render "edit"
    end
  end

private

  def item_params
    params.require(:item).permit(:item_image, :name, :introduction, :genre_id, :price, :is_active)
  end
end
