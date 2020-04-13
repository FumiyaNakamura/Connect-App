require "rails_helper"
include SessionsHelper

RSpec.describe UsersController, type: :controller do
    
    describe "#new" do
        it "正常なレスポンスが返ってくる" do
           get :new
           expect(response).to be_success
        end
        
        it "200レスポンスが返ってくる" do
            get :new
            expect(response).to have_http_status "200"
        end
    end
    
    describe "#create" do
        context "有効なユーザーで登録" do
            it "302レスポンスが返ってくる" do
                post :create, params: { user: { name: "tatsuro", email: "tatsuro@example.com", password: "password"} } 
                expect(response).to have_http_status "302"
            end
            
            it "usersテーブルのレコード数が１つ増える" do
                expect{ 
                    post :create, params: { user: { name: "tatsuro", email: "tatsuro@example.com", password: "password"} } 
                }.to change{ User.count }.by(1)
            end

            it "ホーム画面にリダイレクトする" do
                post :create, params: { user: { name: "tatsuro", email: "tatsuro@example.com", password: "password"} } 
                expect(response).to redirect_to root_url
            end
        end
        
        context "無効なメールアドレスで登録" do
            it "ユーザー登録画面にレンダリングする" do
                post :create, params: { user: { name: "tatsuro", email: "aaaa", password: "password"} } 
                expect(response).to render_template("new")
            end
        end
    end
    
    describe "#show" do
        before do
            @user = FactoryBot.create(:user)
        end
        
        it "正常なレスポンスが返ってくる" do
           get :show, params: { id: @user.id }
           expect(response).to be_success
        end
        
        it "200レスポンスが返ってくる" do
            get :show, params: { id: @user.id }
            expect(response).to have_http_status "200"
        end
    end
    
    describe  "#index" do
        before do
            @user = FactoryBot.create(:user)
        end
        
        context "ログインしているユーザーの時" do
            it "200レスポンスが返ってくる" do
                log_in(@user)
                get :index, params: { page: 1 }
                expect(response.status).to eq 200
            end
        end
        
        context "ログインしていないユーザーの時" do
            it "200レスポンスが返ってこない" do
                get :index, params: { page: 1 }
                expect(response.status).to_not eq 200
            end
            
            it "302レスポンスが返ってくる" do
                get :index, params: { page: 1 }
                expect(response.status).to eq 302
            end
        end
    end
    
    describe  "#edit" do
        before do
            @user = FactoryBot.create(:user)
        end
            
        context "ログインしているユーザーの時" do
            it "200レスポンスが返ってくる" do
                log_in(@user)
                get :edit, params: { id: @user.id }
                expect(response.status).to eq 200
            end
        end
        
        context "ログインしていないユーザーの時" do
            it "200レスポンスが返ってこない" do
                get :edit, params: { id: @user.id }
                expect(response.status).to_not eq 200
            end
            
            it "302レスポンスが返ってくる" do
                get :edit, params: { id: @user.id }
                expect(response.status).to eq 302
            end
        end
    end
    
    describe  "#update" do
        before do
            @user = FactoryBot.create(:user)
        end
        
        context "ログインしているユーザーの時" do
            it "ユーザーを更新できる" do
                log_in(@user)
                patch :update, params: { id: @user.id, user: { name: "maru" } }
                expect(@user.reload.name).to eq "maru"
            end
            
            it "ユーザー詳細画面にリダイレクトする" do
                log_in(@user)
                patch :update, params: { id: @user.id, user: { name: "maru" } }
                expect(response).to redirect_to @user
            end
        end
        
        context "ログインしていないユーザーの時" do
            it "200レスポンスが返ってこない" do
                get :update, params: { id: @user.id }
                expect(response.status).to_not eq 200
            end
            
            it "302レスポンスが返ってくる" do
                get :update, params: { id: @user.id }
                expect(response.status).to eq 302
            end
        end
    end
end