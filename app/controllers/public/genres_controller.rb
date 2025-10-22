class Public::GenresController < ApplicationController
  def index
		@genres = Genre.limit(8)
  end

	def show
    @genre = Genre.find(params[:id])
    @genres = Genre.limit(8)
    @items = @genre.items.where(is_active: true).page(params[:page])
  end

end
