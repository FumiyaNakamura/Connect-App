require 'rails_helper'

RSpec.describe AccountActivationsController, type: :controller do
  before do
    @user = FactoryBot.create(:unactivate_user)
  end
  
  it "有効なリンクのとき、ユーザー詳細画面にリダイレクトする" do
    get :edit, params: { email: "yoshi@example.com", id: @user.activation_token }
    expect(response).to redirect_to @user
  end
  
  it "無効なリンクのとき、ホーム画面にリダイレクトする" do
    get :edit, params: { email: "yoshi@example.com", id: "xxx" }
    expect(response).to redirect_to root_url
  end

end
