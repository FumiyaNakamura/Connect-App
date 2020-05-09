class GuestSessionsController < ApplicationController

  def create
    @user = User.find_by(email: 'test@example.com')
    log_in(@user)
    flash[:success] = 'ゲストユーザーでログインしました。'
    flash[:warning] = 'ゲストユーザーは、ユーザー編集機能以外を使用できます。よろしくお願いします！'
    redirect_to @user
  end
end
