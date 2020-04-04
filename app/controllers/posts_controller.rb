class PostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    
    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            flash[:success] = "投稿しました"
            redirect_to root_url
        else
            @user = current_user
            @feed_items = @user.feed.paginate(page: params[:page])
            render "static_pages/home"
        end
    end
    
    def destroy
    end
    
    private
        
        def post_params
           params.require(:post).permit(:title, :content) 
        end
end
