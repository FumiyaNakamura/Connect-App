require 'rails_helper'
include SessionsHelper

RSpec.describe PostsController, type: :controller do
    before do
        @user = FactoryBot.create(:user)
    end
    
    describe "#create" do
        context "投稿できる" do
            it "投稿するとpostsテーブルのレコード数が1つ増える" do
                log_in(@user)
                expect{
                    post :create, params: { post: { title: "数学",content: "3時間やった！" } }
                }.to change{ Post.count }.by(1)
            end
            
            it "ルートURLにリダイレクトする" do
                log_in(@user)
                post :create, params: { post: { title: "数学",content: "3時間やった！" } }
                expect(response).to redirect_to root_url
            end
        end
        
        context "投稿できない" do
           it "未ログインなら、postsテーブルのレコード数が変化しない" do
               expect{
                    post :create, params: { post: { title: "数学",content: "3時間やった！" } }
                }.to change{ Post.count }.by(0)
           end
           
           it "無効な投稿で、ホーム画面にレンダリングする" do
               log_in(@user)
               post :create, params: { post: { title: "数学",content: "" } }
               expect(response).to render_template("static_pages/home")
           end
        end
    end
    
    describe "#destroy" do
        before do
            log_in(@user)
            post :create, params: { post: { title: "数学",content: "3時間やった！" } } 
        end
        
        it "投稿の削除" do
            expect{
                delete :destroy, params: { id: 1 }
            }.to change{ @user.posts.count }.by(-1)
        end
    end


end
