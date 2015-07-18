class AddIndexes < ActiveRecord::Migration
  def change
    add_index "users", ["name"], name: "index_user_by_name", unique: true
    add_index "suggestions", ["location", "day_id", "departure_time"], name: "index_suggestions_by_location, day_id,_and_departure_time", unique: true
  end
end
