class UpdateSuggestionIndex < ActiveRecord::Migration
  def change
  	remove_column "suggestions", "depature_time"
  end
end
