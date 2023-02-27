Rails.application.routes.draw do
  # Users
  resources :users, only: [:index, :show, :create] do
    # Sleep Records
    resources :sleep_records, only: [:index, :create, :update]
    # User Follows
    resources :user_follows, only: [:index, :create, :destroy]
    # User Followers Sleep Records
    get "/user_follows/sleep_records", to: "user_follows#followers_sleep_records"
  end
end
