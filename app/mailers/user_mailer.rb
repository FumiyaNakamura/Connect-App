class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Connectへようこそ！"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワードの再設定"
  end
end
