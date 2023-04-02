class FavoritesController < ApplicationController
  def create
    menu = Menu.find(params[:menu_id])
    current_user.decorate.favorite(menu)
    redirect_back fallback_location: root_path, success: t('defaults.message.register', item: Favorite.model_name.human)
  end

  def destroy
    menu = current_user.favorites.find(params[:id]).menu
    current_user.decorate.unfavorite(menu)
    redirect_back fallback_location: root_path, success: t('defaults.message.unregister', item: Favorite.model_name.human)
  end
end
