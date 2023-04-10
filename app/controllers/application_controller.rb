class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login

  rescue_from CanCan::AccessDenied do
    redirect_to main_app.root_path, danger: t('defaults.message.stop_access')
  end

  protected

  def not_authenticated
    redirect_to main_app.login_path, danger: t('defaults.message.require_login')
  end
end
