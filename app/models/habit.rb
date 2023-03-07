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

  def sentence
    done_yesterday ? (value = current_streak) : (value = current_gap)
    sentence = []
    case timeframe(value)
    when 'days'
      days = value
      days > 1 ? sentence.push("#{days} days") : sentence.push("#{days} day")
    when 'weeks'
      weeks = value.divmod(7)[0]
      weeks > 1 ? sentence.push("#{weeks} weeks") : sentence.push("#{weeks} week")
      days = value.divmod(7)[1]
      days > 1 ? sentence.push("#{days} days") : sentence.push("#{days} day")
    when 'months'
      months = value.divmod(30)[0]
      months > 1 ? sentence.push("#{months} months") : sentence.push("#{months} month")
      weeks = value.divmod(30)[1].divmod(7)[0]
      weeks > 1 ? sentence.push("#{weeks} weeks") : sentence.push("#{weeks} week")
      days = value.divmod(30)[1].divmod(7)[1]
      days > 1 ? sentence.push("#{days} days") : sentence.push("#{days} day")
    when 'years'
      years = value.divmod(365)[0]
      years > 1 ? sentence.push("#{years} years") : sentence.push("#{years} year")
      months = value.divmod(365)[1].divmod(30)[0]
      months > 1 ? sentence.push("#{months} months") : sentence.push("#{months} month")
      weeks = value.divmod(365)[1].divmod(30)[1].divmod(7)[0]
      weeks > 1 ? sentence.push("#{weeks} weeks") : sentence.push("#{weeks} week")
      days = value.divmod(365)[1].divmod(30)[1].divmod(7)[1]
      days > 1 ? sentence.push("#{days} days") : sentence.push("#{days} day")
    end
    sentence.join(", ")
  end

  # Need to schedule new_day to run first thing each morning
  def new_day
    self.done_yesterday = self.done_today
    self.done_today = false
    self.current_streak = 0 unless @done_today
  end

  private

  def timeframe(value)
    case value
    when 1..6
      'days'
    when 7..29
      'weeks'
    when 30..364
      'months'
    when value > 365
      'years'
    end
  end

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
    self.current_gap = 1
  end

  def undo_reset_gap
    self.current_gap = @last_gap
  end
end
