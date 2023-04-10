class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login

  protected

  def not_authenticated
    redirect_to main_app.login_path, danger: t('defaults.message.require_login')
  end
end
