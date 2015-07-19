class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string  "location",              default: "",    null: false
      t.string  "departure_time",        default: "",    null: false
      t.integer "day_id",                default: 0,     null: false
      t.integer "votes",                 default: 0,     null: false
      t.integer "winner",                default: 0,     null: false
      t.timestamps
    end
  end
end
