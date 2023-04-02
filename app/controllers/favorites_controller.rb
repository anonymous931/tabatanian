class FavoritesController < ApplicationController
  def create
    menu = Menu.find(params[:menu_id])
    current_user.favorite(menu)
    redirect_back_or_to root_path, success: t('defaults.message.register', item: Favorite.model_name.human )
  end

  def destroy
    menu = current_user.favorites.find(params[:id]).menu
    current_user.unfavorite(menu)
    redirect_back_or_to root_path, success: t('defaults.message.unregister', item: Favorite.model_name.human )
  end
end
