class AddIndexes < ActiveRecord::Migration
  def change
    add_index "users", ["name"], name: "index_user_by_name", unique: true
    add_index "suggestions", ["location", "departure_time"], name: "index_suggestions_by_location_and_departure_time", unique: true
  end
end
