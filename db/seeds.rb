# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'date'

print 'Destroying familylinks...'
Familylink.destroy_all
puts 'done'
print 'Destroying children...'
Child.destroy_all
puts 'done'
print 'Destroying classrooms...'
Classroom.destroy_all
puts 'done'
print 'Destroying posts...'
Post.destroy_all
puts 'done'
print 'Destroying messages...'
Message.destroy_all
puts 'done'
print 'Destroying conversations...'
Conversation.destroy_all
puts 'done'
print 'Destroying notifications...'
Notification.destroy_all
puts 'done'
print 'Destroying users...'
User.destroy_all
puts 'done'

classes = [
          { name: "CPa", teacher: "Talbi", teacher_gender: "female" },
          { name: "CPb", teacher: "Couriau", teacher_gender: "female" },
          { name: "CE1", teacher: "Gonçalves", teacher_gender: "female" },
          { name: "CE1-CE2", teacher: "Ducournau", teacher_gender: "female" },
          { name: "CE2-CM1", teacher: "LeCossec", teacher_gender: "female" },
          { name: "CM1-CM2", teacher: "Bisacara", teacher_gender: "female" },
          { name: "CM2", teacher: "Rakotovelo", teacher_gender: "female" } ]

children = [ { first_name: "Zoé", last_name: "Delabracherie"},
             { first_name: "Arthur", last_name: "Delabracherie"} ]

users = [ { first_name: "Florence", last_name: "Dostes",
            email: "em1@gm.com", password: "12345678"},
          { first_name: "Florian", last_name: "Delabracherie",
            email: "em2@gm.com", password: "12345678"},
          { first_name: "Michael", last_name: "Ramassamy",
            email: "ramassamymichael@gmail.com", password: "12345678", admin: true}]

posts = [
          { title: "Le conseil d'école" },
          { title: "Le conseil des parents de Lange" },
          { title: "Le bureau du conseil des parents" } ]

print 'Seeding users'
number = 1
users.each do |userdata|
  user = User.new(userdata)
  number += 1
  user.save!
  user.confirm
  print '.'
end
puts 'done'

print 'Seeding classrooms'
code_array = ('A'..'Z').to_a + ('0'..'9').to_a
classes.each do |classdata|
  classroom = Classroom.new(classdata)
  classroom.signin_code = code_array.sample(5).join
  classroom.save!
  print '.'
end
puts 'done'

print 'Seeding children'
children.each do |childdata|
  child = Child.new(childdata)
  child.classroom = Classroom.find_by_name("CM2")
  child.save!
  print '.'
end
puts 'done'

print 'Seeding familylink'
Familylink.create!(user: User.first, child: Child.first, parental_link: 1)
Familylink.create!(user: User.all[1], child: Child.last, parental_link: 0)
puts '..done'

print 'Seeding posts'
posts.each do |postdata|
  post = Post.new(postdata)
  post.content = Faker::Lorem.paragraph
  post.user = User.last
  post.save!
  print '.'
end
puts 'done'

print 'Seeding conversations'
users = User.first(3)
3.times do |number1|
  3.times do |number2|
    c = Conversation.new(user1: users[number1], user2: users[number2])
    if c.save
      print '.'
    else
      print 'x'
    end
  end
end
puts 'done'


print 'Seeding messages'
Conversation.all.each do |conversation|
  conversation.messages.create!(content: Faker::Simpsons.quote, author: conversation.user1)
  print '.'
  conversation.messages.create!(content: Faker::BackToTheFuture.quote, author: conversation.user2)
  print '.'
  conversation.messages.create!(content: Faker::Simpsons.quote, author: conversation.user1)
  print '.'
end
puts 'done'
