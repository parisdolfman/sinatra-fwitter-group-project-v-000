class TweetsController < ApplicationController
    get '/tweets' do
        if logged_in?
          @tweets = Tweet.all
          erb :'tweets/tweet_list'
        else
          redirect to '/login'
        end
      end

      get '/tweets/new' do
        if logged_in?
          erb :'tweets/new'
        else
          redirect to '/login'
        end
      end

end

get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :'tweets/edit_'
      else
        redirect to '/tweet_list'
      end
    else
      redirect to '/login'
    end
  end
