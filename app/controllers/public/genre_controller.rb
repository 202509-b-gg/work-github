class Public::GenreController < ApplicationController
  def index
  end

  def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		@records = Item.search_for(@content, @method)
end
