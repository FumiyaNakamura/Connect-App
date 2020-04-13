require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  before do
    @user = FactoryBot.create(:activate_user)
  end
  
  describe "#new" do
    it "200レスポンスが返ってくる" do
      get :new
      expect(response.status).to eq 200
    end 
  end
  
  describe "#create" do
    it "存在するメールアドレスのとき、ホーム画面にリダイレクトする" do
      post :create, params: { password_reset: {email: "yoshi@example.com" } }
      expect(response).to redirect_to root_url
    end
    
    it "存在しないメールアドレスのとき、パスワードを忘れた方の画面にレンダリングさせる" do
      post :create, params: { password_reset: {email: "xxx" } }
      expect(response).to render_template "new"
    end
  end
  
  describe "#edit" do
    it "有効なトークンのとき、200レスポンスが返ってくる" do
      get :edit, params: { email:"yoshi@example.com", id: @user.reset_token }
      expect(response.status).to eq 200
    end
    
    it "無効なトークンのとき、302レスポンスが返ってくる" do
      get :edit, params: { email:"yoshi@example.com", id: "xxx" }
      expect(response.status).to eq 302
    end
  end
  
  describe "#update" do
    context "有効なユーザー" do
      it "パスワードが空のとき、パスワード再設定画面にレンダリングする" do
        patch :update, params: { email:"yoshi@example.com", id: @user.reset_token, user: { password: "", password_confirmation: "" }}
        expect(response).to render_template "edit"
      end
      
      it "パスワードが更新できたとき、ユーザー詳細画面にリダイレクトする" do
        patch :update, params: { email:"yoshi@example.com", id: @user.reset_token, user: { password: "abcdef", password_confirmation: "abcdef" }}
        expect(response).to redirect_to @user
      end
      
      it "パスワードが更新できなかったとき、パスワード再設定画面にレンダリングする" do
        patch :update, params: { email:"yoshi@example.com", id: @user.reset_token, user: { password: "abcdef", password_confirmation: "xxxxxx" }}
        expect(response).to render_template "edit"
      end
    end
    
  end
  
end
