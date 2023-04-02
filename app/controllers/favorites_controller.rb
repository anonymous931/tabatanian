class FavoritesController < ApplicationController
  def create
    @menu = Menu.find(params[:menu_id])
    current_user.decorate.favorite(@menu)
  end

  def destroy
    @menu = current_user.favorites.find(params[:id]).menu
    current_user.decorate.unfavorite(@menu)
  end
end
