class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.date :date, unique=true

      t.timestamps
    end
  end
end
