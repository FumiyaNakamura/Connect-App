require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before do
        @user = FactoryBot.create(:activate_user)
        @post = FactoryBot.create(:post)
  end
  
  describe "#new" do
    it "200レスポンスが返ってくる" do
      get :new, params: { post_id: @post.id}
      expect(response.status).to eq 200
    end
  end
  
  describe "#create" do
    it "コメントすると、commentsテーブルのレコード数が一つ増える" do
      expect{
        post :create, params: { post_id: 1 , comment: { content: "いい感じですね！"} }, session: { user_id: @user.id }
      }.to change{ @post.comments.count }.by(1)
    end
  end
  
  describe "#destroy" do
    it "コメントを消すと、commentsテーブルのレコード数が一つ減る" do
      post :create, params: { post_id: 1 , comment: { content: "いい感じですね！"} }, session: { user_id: @user.id }
      expect{
        delete :destroy, params: { post_id: 1 }, session: { user_id: @user.id }
      }.to change{ @post.comments.count }.by(-1)
    end
  end


end
