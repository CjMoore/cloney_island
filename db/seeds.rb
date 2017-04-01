Comment.destroy_all
Project.destroy_all
UserRole.destroy_all
Role.destroy_all
User.destroy_all

class Seed
  def self.start
    seed = Seed.new
    seed.generate_projects
    seed.generate_users
    seed.generate_comments
  end

  def generate_projects
    50.times do |i|
      project = Project.create!(
      name: Faker::Hipster.words.join(" "),
      description: Faker::Hipster.sentence(3),
      total: Faker::Number.between(1000, 20000),
      time: Faker::Time.forward(Random.new.rand(3..30), :morning),
      image_url: "http://www.fillmurray.com/g/200/200"
      )
      puts "Project Name: #{project.name} #{i}"
    end
  end

  def generate_users
    30.times do |i|
      user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      username: Faker::Name.name,
      password: "password",
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.cell_phone,
      avatar_url: Faker::Avatar.image
      )
      role = Role.find_or_create_by(name: "registered_user")
      user.roles << role
      puts "#{i} User: #{user.username} created"
    end
  end

  def generate_comments
    Project.all.each do |project|
      2.times do |i|
        first_user = User.first.id
        last_user = User.last.id
        comment = Comment.create(project: project,
        author: User.find(Random.new.rand(first_user..last_user)).username,
        content: Faker::Lorem.sentence)

        puts "Comment by: #{comment.author} created"
      end
    end
  end

  def generate_funds

  end
end

Seed.start
