class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    current_user.decorate.follow(params[:user_id])
  end

  def destroy
    current_user.decorate.unfollow(params[:user_id])
  end

  # フォローしている人一覧
  def follower
    @users = @user.followings.page(params[:page])
  end

  # フォローされている人一覧
  def followed
    @users = @user.followers.page(params[:page])
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
