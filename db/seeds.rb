UserFundedProject.destroy_all
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
    seed.generate_funds
    seed.generate_me
  end

  def generate_projects
    154.times do |i|
      project = Project.create!(
      name: Faker::Hipster.words.join(" "),
      description: Faker::Hipster.sentence(3),
      total: Faker::Number.between(1000, 20000),
      time: Faker::Time.forward(Random.new.rand(10..30), :morning),
      image_url: "http://www.fillmurray.com/g/200/200"
      )
      puts "Project Name: #{project.name} #{i}"
    end
  end

  def generate_users
    300.times do |i|
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
    400.times do |i|
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
      project = Project.find(Random.new.rand(Project.all.first.id..Project.all.last.id))
      UserFundedProject.create(amount: Faker::Number.between(100, 2000),
                                credit_card_number: Faker::Business.credit_card_number,
                                user: user,
                                project: project)
      funder = Role.find_or_create_by(name: "project_funder")
      user.roles << funder

      puts "#{user.username} funded #{project.name}"
    end
  end

  def generate_me
    user = User.create!(first_name: "Charlotte",
                last_name: "Moore",
                username: "itsame",
                email: "mooc123@gmail.com",
                phone: "2025313141",
                avatar_url: "http://www.placecage.com/c/200/200",
                password: "pass",
                token: "abc123")
    user.roles << Role.find_by(name: "registered_user")
    puts "created me"
  end
end

Seed.start
