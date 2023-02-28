# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts 'Creating some seeds...'
Habit.create(name: 'Play guitar')
puts '...habit created - play guitar'
Habit.create(name: 'Workout')
puts '...habit created - workout'
Habit.create(name: 'Brush teeth')
puts '...habit created - brush teeth'
puts 'Finished creating seeds.'
