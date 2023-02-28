class CreateHabits < ActiveRecord::Migration[7.0]
  def change
    create_table :habits do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.boolean :done_today
      t.integer :current_streak
      t.integer :longest_streak
      t.integer :current_gap
      t.integer :last_gap

      t.timestamps
    end
  end
end
