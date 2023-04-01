class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ update destory ]
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end

  def update
    @comment.update(body: comment_params[:body])
  end

  def destroy
    @comment.destroy!
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body).merge(menu_id: params[:menu_id])
  end
end
