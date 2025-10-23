class Public::GenresController < ApplicationController

  before_action :authenticate_customer!

  def index
		@genres = Genre.all
  end

	def show
    @genre = Genre.find(params[:id])
    @genres = Genre.all
    @items = @genre.items.where(is_active: true).page(params[:page])
  end

end
