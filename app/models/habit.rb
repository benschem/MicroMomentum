class Habit < ApplicationRecord
  belongs_to :user
  validates :name, presence: true

  def change_state
    done_today ? mark_not_done : mark_done
  end

  def progress
    return 0 if longest_streak.nil? || longest_streak.zero?

    (current_streak.to_f.fdiv(longest_streak.to_f) * 100).to_i
  end

  # Need to schedule new_day to run first thing each morning
  def new_day
    self.done_yesterday = self.done_today
    self.done_today = false
    self.current_streak = 0 unless @done_today
  end

  private

  def mark_done
    self.done_today = true
    increase_streak
    reset_gap
  end

  def mark_not_done
    self.done_today = false
    undo_increase_streak
    undo_reset_gap
  end

  def increase_streak
    self.current_streak += 1
    self.longest_streak += 1 if current_streak > longest_streak
  end

  def undo_increase_streak
    self.current_streak -= 1
    self.longest_streak -= 1 if longest_streak > current_streak
  end

  def reset_gap
    self.last_gap = @current_gap
    self.current_gap = 0
  end

  def undo_reset_gap
    self.current_gap = @last_gap
  end
end
