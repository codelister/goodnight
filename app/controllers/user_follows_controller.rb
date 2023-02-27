class UserFollowsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @user = User.find(params[:user_id])
    @user_follows = UserFollow.where(followee_id: @user.id)
    render json: @user_follows
  end

  def create
    # Get the user
    @user = User.find(params[:user_id])
    # Get the user to follow
    @user_to_follow = User.find(params[:follower_id])
    # Create the user follow
    @user_follow = UserFollow.new(followee_id: @user.id, follower_id: @user_to_follow.id)
    # Save the user follow
    if @user_follow.save
      # Render the user follow as JSON
      render json: @user_follow
    else
      # Render the user follow's errors as JSON
      render json: @user_follow.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # Get the user follow
    @user_follow = UserFollow.find(params[:id])
    # Destroy the user follow
    @user_follow.destroy
    # Render the user follow as JSON
    render json: @user_follow
  end

  def followers_sleep_records
    # Get the user
    @user = User.find(params[:user_id])
    # Get the user's followers
    @user_follows = UserFollow.where(followee_id: @user.id)
    # Get the sleep records for the last week, ordered by length of sleep
    week_ago = 1.week.ago.beginning_of_day
    @sleep_records = SleepRecord.where(user_id: @user_follows.map(&:follower_id)).where("created_at >= ?", week_ago)
    .select("*, sleep_time - wake_time AS duration")
    .order("duration DESC")
    render json: @sleep_records
  end

end
