class CommentsController < ApplicationController
  before_action :set_post, only: [:create, :destroy]
  before_action :require_user

  def create
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user

    if @comment.save

      flash[:success] = "Comment was successfully created"

      redirect_to post_path(@post)
    else

      flash.now[:danger] = "Comment can't be blank"

      render 'posts/show'

    end

  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    flash[:success] = "Comment was successfully deleted"

    redirect_to post_path(@post)
  end

  private
  def set_post
    @post = Post.find_by(id: params[:post_id])
  end
  def comment_params
    params.require(:comment).permit(:body, :user, :post)
  end
end
