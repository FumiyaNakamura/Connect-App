class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "メールを確認して、アカウントを有効にしてください"
      redirect_to root_url
    else
      render "new"
    end
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def search
    @users = User.search(params[:search])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールが更新されました"
      redirect_to @user
    else
      render "edit"
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, 
                                   :password_confirmation, :image)
    end
    
    # beforeアクション
    
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirct_to(root_url) unless current_user?(@user)
    end
end
