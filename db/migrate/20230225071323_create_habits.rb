class CreateHabits < ActiveRecord::Migration[7.0]
  def change
    create_table :habits do |t|
      t.string :name
      t.boolean :done_today
      t.integer :current_streak
      t.integer :streak_record
      t.integer :current_gap
      t.integer :total_done
      t.integer :total_gap
      # t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
