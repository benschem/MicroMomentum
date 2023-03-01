# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts 'Cleaning database...'
User.destroy_all
Habit.destroy_all

puts "Creating a user..."
test_user = User.create!(email: 'test@test.com', password: '123456')
puts "...#{test_user.email} created"
puts "...#{test_user.email}'s password is #{test_user.password}"

puts 'Creating some habits...'
demo_habits = ['Play Guitar', 'Workout', 'Duolingo']
demo_habits.each do |habit|
  new_habit = Habit.create!(name: habit, user: test_user)
  puts "...#{new_habit.name} created"
end

puts 'Finished creating seeds.'
