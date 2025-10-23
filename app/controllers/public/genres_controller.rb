class Public::GenresController < ApplicationController
  def index
		@genres = Genre.all

	def show
    @genre = Genre.find(params[:id])
    @genres = Genre.all
    @items = @genre.items.where(is_active: true).page(params[:page])
  end

end
