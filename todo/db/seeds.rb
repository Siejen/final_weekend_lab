# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

pete = User.create({first_name: "Pete", last_name: "Stevenson", email: "pete@ga.com", password: "2014password"})
milo = User.create({first_name: "Milo", last_name: "Stevenson", email: "milo@ga.com", password: "2014password"})
nano = User.create({first_name: "Nano", last_name: "Stevenson", email: "nano@ga.com", password: "2014password"})

date1 = Date.new(2014, 9, 14)
date2 = Date.new(2014, 9, 15)
date3 = Date.new(2014, 9, 25)

task1 = pete.tasks.create({task_name: "Make a sandwich for Siejen", due_date: date1, task_complete: false})
task2 = milo.tasks.create({task_name: "Have frontline and heartgard", due_date: date2, task_complete: false})
task3 = nano.tasks.create({task_name: "Hop on the hamster wheel", due_date: date3, task_complete: false})
