# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts 'Cleaning database...'
Habit.destroy_all

puts 'Creating some seeds...'

demo_habits = ['Play Guitar', 'Workout', 'Duolingo']
demo_habits.each do |habit|
  new_habit = Habit.create!(name: habit, user: User.last)
  puts "...#{new_habit.name} created..."
end

puts 'Finished creating seeds.'
