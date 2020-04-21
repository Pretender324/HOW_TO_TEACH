# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(:email => 'test@test.com', :password => 'hugahuga')
user.save!

5.times do |n|
    Post.create!(
        title: "test#{n + 1}",
        contents: "テスト太郎#{n + 1}",
        style: "集団"
        subject: "数学"
        grade: "中学生"
        user_id: "1"
    )
  end