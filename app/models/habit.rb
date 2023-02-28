class Habit < ApplicationRecord
  belongs_to :user
  attr_accessor :name

  def initialize(name)
    @name = name
    @done_today = false
    @current_streak = 0
    @longest_streak = 0
    @current_gap = 0
    @last_gap = 0
    # @sort_position = 0 => rails g migration add_sort_position_to_habit sort_position:integer
  end

  def user_click
    unless @done_today
      @done_today = true
      increase_streak
      reset_gap
    else
      @done_today = false
      undo_increase_streak
      undo_reset_gap
    end
  end

  # Need to schedule this to run each morning first thing
  def new_day
    @done_today = false
  end

  # def custom_sort(position)
  #   @sort_position = position
  # end

  private

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
