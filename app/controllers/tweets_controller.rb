class TweetsController < ApplicationController

  before_action :move_to_index, except: [:index, :show]
    # newアクションとcreateアクションの前でのみ動かす

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(8)
  end

  def new
  end

  def create
    Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)
                  # ツイート保存時に、user_idに現在ログイン中のユーザーidを保存
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy if tweet.user_id == current_user.id
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.update(tweet_params)
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments.includes(:user)
  end

  private
  def tweet_params
    params.permit(:name, :image, :text)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
    # ログインしていない時に投稿しようとするとindexアクションにredirectされる
  end

end
