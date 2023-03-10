class Habit < ApplicationRecord
  belongs_to :user
  validates :name, presence: true

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

  def progress
    return 0 if self.longest_streak.nil? || self.longest_streak.zero?

    (self.current_streak.to_f.fdiv(self.longest_streak.to_f) * 100).to_i
  end

  def days_as_sentence(given_days)
    sentence_parts = []

    years, remainder = extract_timeframe(given_days, 365, 'year')
    sentence_parts << years if years

    months, remainder = extract_timeframe(remainder, 31, 'month')
    sentence_parts << months if months

    weeks, remainder = extract_timeframe(remainder, 7, 'week')
    sentence_parts << weeks if weeks

    days, remainder = extract_timeframe(remainder, 1, 'day')
    sentence_parts << days if days

    sentence_parts.compact.join(', ')
  end

  private

  # Need to schedule new_day to run first thing each morning
  def new_day
    self.done_yesterday = self.done_today
    self.done_today = false
    self.current_streak = 0 unless self.done_yesterday?
  end

  def extract_timeframe(value, timeframe_length, timeframe_name)
    timeframe_count, remainder = value.divmod(timeframe_length)
    timeframe_string = pluralize(timeframe_count, timeframe_name) if timeframe_count > 0
    [timeframe_string, remainder]
  end

  def timeframe(days)
    case days
    when 1..6
      'days'
    when 7..29
      'weeks'
    when 30..364
      'months'
    else
      'years'
    end
  end

  def pluralize(count, singular_form)
    plural_form = "#{singular_form}s"
    count == 1 ? "#{count} #{singular_form}" : "#{count} #{plural_form}"
  end

  def increase_streak
    self.current_streak += 1
    self.longest_streak += 1 if self.current_streak > self.longest_streak
  end

  def undo_increase_streak
    self.current_streak -= 1
    self.longest_streak -= 1 if self.longest_streak > self.current_streak
  end

  def reset_gap
    self.last_gap = self.current_gap
    self.current_gap = 1
  end

  def undo_reset_gap
    self.current_gap = self.last_gap
  end
end
