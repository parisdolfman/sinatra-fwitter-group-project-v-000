class TweetsController < ApplicationController
    get '/tweets' do
        if logged_in?
          @tweets = Tweet.all
          erb :'tweets/tweets'
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

#NOTE: Below does not solve any errors
# get '/tweets/:id' do
#     case 
#     when logged_in? == true 
#       @tweet = Tweet.find_by_id(params[:id])
#     when @tweet && @tweet.user == current_user
#         erb :'tweets/edit_tweet'
#     when @tweet.update(content: params[:content])
#         redirect to "/tweets/#{@tweet.id}"
#     when !!@tweet.update(content: params[:content])
#         redirect to "/tweets/#{@tweet.id}/edit"
#     when @tweet && !!@tweet.user == current_user
#         redirect to '/tweets'
#     else
#         redirect to '/login'
#       end
#   end

#NNOTE: Below is easiest written way by separation of responsibility. Looking to merge the get and post method.

#  get '/tweets/:id/edit' do
#    if logged_in?
#       if @tweet && @tweet.user == current_user
#       @tweet = Tweet.find_by_id(params[:id])
#       if @tweet && @tweet.user == current_user
#         erb :'tweets/edit_tweet'
#       else
#         redirect to '/tweets'
#       end
#     else
#       redirect to '/login'
#     end
#   end

  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect to "/tweets/new"
      else
        @tweet = current_user.tweets.build(content: params[:content])
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect to "/tweets/new"
        end
      end
    else
      redirect to '/login'
    end
  end

