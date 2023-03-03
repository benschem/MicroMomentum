class CreateHabits < ActiveRecord::Migration[7.0]
  def change
    create_table :habits do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.boolean :done_today, default: false, null: false
      t.integer :current_streak, default: 0, null: false
      t.integer :longest_streak, default: 0, null: false
      t.integer :current_gap, default: 1, null: false
      t.integer :last_gap, default: 0, null: false

      t.timestamps
    end
  end
end
