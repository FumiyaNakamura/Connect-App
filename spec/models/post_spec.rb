require "rails_helper"

RSpec.describe Post, type: :model do
    before do
        @user = FactoryBot.create(:user)
        @post = @user.posts.build(title: "プログラミング学習", content: "今日はRspecについて学ぶ！")
    end
    
    context "バリデーションがOK" do
        it "タイトルと内容がある" do
            expect(@post).to be_valid
        end
        
        it "タイトルが50文字以下" do
            @post.title = "a" * 50
        end
        
        it "本文が300文字以下" do
            @post.content = "a" * 301
        end
    end
    
    context "バリデーションがNG" do
        it "ユーザーIDが空" do
            @post.user_id = nil
            expect(@post).to_not be_valid
        end
        
        it "タイトルが空" do
            @post.title = ""
            expect(@post).to_not be_valid
        end
        
        it "内容が空" do
            @post.content = ""
            expect(@post).to_not be_valid
        end
        
        it "タイトルが51文字以上" do
            @post.title = "a" * 51
            expect(@post).to_not be_valid
        end
        
        it "本文が301文字以上" do
            @post.content = "a" * 301
            expect(@post).to_not be_valid
        end
        
    end
end
