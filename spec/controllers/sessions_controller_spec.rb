require 'rails_helper'
include SessionsHelper

RSpec.describe SessionsController, type: :controller do
    before do
        @user = FactoryBot.create(:user)
    end
    
    describe "#create" do
        it "ログインできれば、ユーザー詳細画面に遷移する" do
            post :create, params: { session: { email: "tatsuro6@example.com", password: "password", remember_me: 1 } }
            expect(response).to redirect_to @user
        end
        
        it "パスワードが間違っている時、ログイン画面にレンダリングする" do
            post :create, params: { session: { email: "tatsuro6@example.com", password: "aaaaaa", remember_me: 1 } }
            expect(response).to render_template "sessions/new"
        end
    end
    
    describe "#destroy" do
       it "ホーム画面にリダイレクトする" do
          delete :destroy
          expect(response).to redirect_to root_url
       end
    end
end