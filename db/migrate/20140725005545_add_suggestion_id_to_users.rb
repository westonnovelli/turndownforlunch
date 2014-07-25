class AddSuggestionIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :suggestion_id, :integer
  end
end
