class Public::GenresController < ApplicationController
  def index
		@genres = Genre.limit(10)
  end

	def show
    @genre = Item.where(is_active: true)
    @items = Item.where(is_active: true).page(params[:page])
  end

end
