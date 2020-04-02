require "rails_helper"

RSpec.describe User, type: :model do
    it "名前とメールアドレスとパスワードがあれば登録できる" do
        expect(FactoryBot.build(:user)).to be_valid
    end
    
    it "名前がなければ登録できない" do
        expect(FactoryBot.build(:user, name: "")).to_not be_valid
    end
    
    it "メールアドレスがなければ登録できない" do
        expect(FactoryBot.build(:user, email:"")).to_not be_valid
    end
    
    it "メールアドレスが重複していたら登録できない" do
        user1 = User.create(name: "yoshi", email: "yoshi@example.com", password:"password")
        expect(FactoryBot.build(:user,email: user1.email)).to_not be_valid
    end
    
    it "パスワードがなければ登録できない" do
        expect(FactoryBot.build(:user, password: "")).to_not be_valid
    end
    
    it "パスワードが暗号化されているか" do
        user = FactoryBot.create(:user)
        expect(user.password_digest).to_not eq "password"
    end
    
    it "パスワードが5文字以下であれば登録できない" do
        expect(FactoryBot.build(:user, password: "a"*5)).to_not be_valid
    end
    
    it "メールアドレスが256文字以上なら登録できない" do
       expect(FactoryBot.build(:user, email: "a"*244 + "@example.com")).to_not be_valid 
    end
    
    it "有効ではないメールアドレスでは登録できない" do
       expect(FactoryBot.build(:user, email: "hoge@@example.com")).to_not be_valid 
    end
end