class AddUserAndSuggestionToVote < ActiveRecord::Migration
  def change
    add_column :votes, :user_id, :integer
    add_column :votes, :suggestion_id, :integer
  end
end
