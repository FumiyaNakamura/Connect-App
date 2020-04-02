require "rails_helper"

RSpec.describe UsersController, type: :controller do
    # before do
    #     @user = FactoryBot.create(:user)
    # end
    
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
            # before do
            #     post :create, params: { user: { name: "tatsuro", email: "tatsuro@example.com", password: "password"} } 
            # end
            it "usersテーブルのレコード数が１つ増える" do
                expect{ 
                    post :create, params: { user: { name: "tatsuro", email: "tatsuro@example.com", password: "password"} } 
                }.to change{ User.count }.by(1)
            end
            
            # it "ログインしているか" do
            #     post :create, params: { user: { name: "tatsuro", email: "tatsuro@example.com", password: "password"} } 
            #     include SessionsHelper
            #     expect(User.find_by(email: "tatsuro@example.com").logged_in?).to eq true
            # end
            
            it "ユーザー詳細画面にリダイレクトする" do
                post :create, params: { user: { name: "tatsuro", email: "tatsuro@example.com", password: "password"} } 
                expect(response).to redirect_to User.find_by(email: "tatsuro@example.com")
            end
        end
        
        context "無効なメールアドレスで登録しようとする時" do
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
            it "正常なレスポンスが返ってこない" do
                # get :index, params: { page: 1 }
                # expect(response).to_not be_success
            end
            
            it "302レスポンスが返ってくる" do
                
            end
        end
    end
    
    describe  "#edit" do
        context "ログインしているユーザーの時" do
            it "正常なレスポンスが返ってくる" do
           
            end
        
            it "200レスポンスが返ってくる" do
            
            end
        end
        
        context "ログインしていないユーザーの時" do
            it "正常なレスポンスが返ってこない" do
                
            end
            
            it "302レスポンスが返ってくる" do
                
            end
        end
    end
    
    describe  "#update" do
        context "ログインしているユーザーの時" do
            it "正常なレスポンスが返ってくる" do
           
            end
        
            it "200レスポンスが返ってくる" do
            
            end
            
            it "ユーザーを更新できる" do
                
            end
            
            it "ユーザー詳細画面にリダイレクトする" do
                
            end
        end
        
        context "ログインしていないユーザーの時" do
            it "正常なレスポンスが返ってこない" do
                
            end
            
            it "302レスポンスが返ってくる" do
                
            end
        end
    end
    
    
    
end