class CreateUserFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :user_follows do |t|
      t.references :follower, null: false, foreign_key: true
      t.references :followee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
