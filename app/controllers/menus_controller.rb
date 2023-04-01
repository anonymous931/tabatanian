class MenusController < ApplicationController
  before_action :require_login, except: %i[ index show ]
  before_action :set_menu, only: %i[ edit update destroy ]

  # GET /menus or /menus.json
  def index
    @q = Menu.ransack(params[:q])
    @menus = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  # GET /menus/1 or /menus/1.json
  def show
    @menu = Menu.find(params[:id])
    @works = @menu.works
    @comment = Comment.new
    @comments = @menu.comments.includes(:user).order(created_at: :desc)
  end

  # GET /menus/new
  def new
    @menu = Menu.new
  end

  # GET /menus/1/edit
  def edit; end

  # POST /menus or /menus.json
  def create
    @menu = current_user.menus.build(menu_params)

    if @menu.save
      redirect_to menu_path(@menu), success: t('defaults.message.created', item: Menu.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_created', item: Menu.model_name.human)
      render :new
    end
  end

  # PATCH/PUT /menus/1 or /menus/1.json
  def update
    if @menu.update(menu_params)
      redirect_to menu_path(@menu), success: t('defaults.message.updated', item: Menu.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Menu.model_name.human)
      render :edit
    end
  end

  # DELETE /menus/1 or /menus/1.json
  def destroy
    @menu.destroy!
    redirect_to menus_path, success: t('defaults.message.delete', item: Menu.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_menu
    @menu = current_user.menus.find_by(id: params[:id])
    redirect_to root_path, danger: t('defaults.message.stop_access') if @menu.nil?
  end

  # Only allow a list of trusted parameters through.
  def menu_params
    params.require(:menu).permit(:title, :content, :thumbnail, :thumbnai_cache, works_attributes: [:id, :title, :content, :_destroy])
  end
end
