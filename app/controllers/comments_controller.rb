class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end
  
  def create
    @post = Post.find(params[:post_id])
    comment = current_user.comments.build(comment_params)
    comment.post_id = @post.id
    comment.save
    flash[:success] = "コメントしました"
    redirect_to request.referer || root_url
  end

  def destroy
    comment = Comment.find_by(post_id: params[:post_id], user_id: current_user.id)
    comment.destroy
    flash[:success] = "コメントを削除しました"
    redirect_to request.referer || root_url
  end
  
  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end