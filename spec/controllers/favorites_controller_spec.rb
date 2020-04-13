require 'rails_helper'
include SessionsHelper

RSpec.describe FavoritesController, type: :controller do
  before do
        @user = FactoryBot.create(:activate_user)
        @post = FactoryBot.create(:post)
  end

  describe "#create" do
    it "いいねすると、favoritesテーブルのレコード数が1つ増える" do
      expect{
        post :create, params: { post_id: @post.id }, session: { user_id: @user.id }
      }.to change{ @post.favorites.count }.by(1)
    end
  end
  
  describe "#destroy" do
    it "いいねを消すと、favoritesテーブルのレコード数が1つ増える" do
      post :create, params: { post_id: @post.id }, session: { user_id: @user.id }
      expect{
        delete :destroy, params: { post_id: @post.id }, session: { user_id: @user.id }
      }.to change{ @post.favorites.count }.by(-1)
    end
  end

end
