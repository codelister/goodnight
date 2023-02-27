class SleepRecordsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @sleep_records = SleepRecord.where(user_id: params[:user_id]).select(params[:select]).order(created_at: :desc)
    render json: @sleep_records
  end

  def create
    @user = User.find(params[:user_id])
    @sleep_record = SleepRecord.new(sleep_time: params[:sleep_time], user_id: @user.id)
    # Save the sleep record
    if @sleep_record.save
      # Render the sleep record as JSON
      render json: @sleep_record
    else
      # Render the sleep record's errors as JSON
      render json: @sleep_record.errors, status: :unprocessable_entity
    end
  end

  def update
    # Get the sleep record
    @sleep_record = SleepRecord.find(params[:id])
    # Update the sleep record
    if @sleep_record.update(wake_time: params[:wake_time])
      # Render the sleep record as JSON
      render json: @sleep_record
    else
      # Render the sleep record's errors as JSON
      render json: @sleep_record.errors, status: :unprocessable_entity
    end
  end
    
end
