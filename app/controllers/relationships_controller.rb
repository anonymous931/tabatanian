class RelationshipsController < ApplicationController
  before_action :set_user, only: %i[ follower followed ]

  def create
    current_user.decorate.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.decorate.unfollow(params[:user_id])
    redirect_to request.referer
  end

  # フォローしている人一覧
  def follower
    @users = @user.followings
  end

  # フォローされている人一覧
  def followed
    @users = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
