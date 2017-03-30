#only generate 50 projects
#generate 1-2 comments per project using lorem ipsum

class Seed
  def self.start
    seed = Seed.new
    seed.generate_projects
    seed.generate_users
  end

  def generate_projects
    50.times do |i|
      project = Project.create!(
      name: "project#{i}",
      description: Faker::StarWars.wookie_sentence,
      total: Faker::Number.between(1, 100),
      time: Faker::Time.between(DateTime.now - 1, DateTime.now),
      image_url: Faker::Avatar.image
      )
      2.times do |i|
        project.comments << Comment.create!(
        author: Faker::Name.name,
        content: Faker::Lorem.sentence(3)
        )
        puts "Comment: #{i} created!"
      end
      puts "Project Name: #{project.name} #{i}"
    end
  end

  def generate_users
    2.times do |i|
      user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      username: "username#{i}",
      password: "password",
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.cell_phone,
      avatar_url: Faker::Avatar.image
      )
    end
  end
end

Comment.destroy_all
Project.destroy_all
User.destroy_all

Seed.start
