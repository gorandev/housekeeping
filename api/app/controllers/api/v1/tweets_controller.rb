class Api::V1::TweetsController < ApplicationController
  def show
    topic = Topic.find_by_querytext(params[:topic])
    unless topic
      head :no_content and return
    end

    render json: Tweet.where(:topic => topic).order(:posted_on).all
  end
end
