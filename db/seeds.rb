# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Create Default Node"
node = Node.where(name: 'default').first_or_create!

puts "Create Admin Group Users"
[:moderator, :admin, :owner,:lixiang,:weijun].each do|name|
  user = User.create(name: name, email: "#{name}@localgravity.com", password: "11111111")
  config = user.config_for(node)
  config.roles << name
  user.save
end

if Rails.env == "sdevelopment"
  puts "Load Test Development Users"
  100.times do
    User.create(name: Faker::NameCN.last_first, email: Faker::Internet.email, password: "11111111")
  end
  
  users = User.all.to_a
  tags = node.tags.map(&:id)
  puts "Load 100 Sample Questions"  
  100.times do
    lorem = [true, false].sample ? Faker::Lorem : Faker::LoremCN
    node.questions.create(title: lorem.sentence, body: lorem.paragraph(10), user: users.sample, tags: tags.sample((1..8).to_a.sample))
  end
  
  node.questions.sample(80).each do|question|
    puts "Create Answer to Question '#{question.title}'"
    (1...100).to_a.sample.times do
      lorem = [true, false].sample ? Faker::Lorem : Faker::LoremCN
      question.answers.create(body: lorem.paragraph(6), user: users.sample)
    end
  end  
  
end