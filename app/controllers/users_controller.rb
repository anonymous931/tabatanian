class UsersController < ApplicationController
  before_action :require_login, only: %i[ show edit update ]
  before_action :set_current_user, only: %i[ edit update ]

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @posted_menus = @user.menus.page(params[:page])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user.build_profile if @user.profile.nil?
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_url, success: t('defaults.message.register', item: User.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_register', item: User.model_name.human)
      render :new
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @user.update(user_params)
      redirect_to user_path(@user), success: t('defaults.message.updated', item: Profile.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Profile.model_name.human)
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_current_user
    if User.find(params[:id]) == current_user
      @user = current_user
    else
      redirect_to root_path, danger: t('defaults.message.stop_access')
    end
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :avatar_cache,
                                profile_attributes: [:id, :introduction, :weight, :fat, :target_weight, :target_fat, :deadline, :_destroy])
  end
end
