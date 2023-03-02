class AddDoneYesterdayToHabits < ActiveRecord::Migration[7.0]
  def change
    add_column :habits, :done_yesterday, :boolean, default: false, null: false
  end
end
