class Habit < ApplicationRecord
  belongs_to :user
  validates :name, presence: true

  def change_state
    @done_today ? mark_not_done : mark_done
  end

  # Need to schedule new_day to run each morning first thing
  def new_day
    @current_streak = 0 unless @done_today
    @done_today = false
  end

  # def custom_sort(position)
  #   @sort_position = position
  # end

  private

  def mark_done
    @done_today = true
    increase_streak
    reset_gap
  end

  def mark_not_done
    @done_today = false
    undo_increase_streak
    undo_reset_gap
  end

  def increase_streak
    @current_streak += 1
    @longest_streak += 1 if @current_streak > @longest_streak
    @date_last_completed = Date.today
  end

  def undo_increase_streak
    @current_streak -= 1
    @longest_streak -= 1 if @longest_streak > @current_streak
    @date_last_completed = Date.yesterday
  end

  def reset_gap
    @last_gap = @current_gap
    @current_gap = 0
  end

  def undo_reset_gap
    @current_gap = @last_gap
  end
end
