class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @tweets = user.tweets.page(params[:page]).per(5).order("created_at DESC")   # 現在ログインしているユーザーの投稿したツイート全てを取得
  end
end
