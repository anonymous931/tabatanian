class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  protected

  def not_authenticated
    redirect_to root_path, danger: t('defaults.message.require_login')
  end
end
