namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke

    admin = User.create!(:name => "Admin",
                         :email => "admin@liveq.com",
                         :password => "qwerty",
                         :password_confirmation => "qwerty")
    admin.toggle!(:admin)

    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end

    50.times do
      User.all(:limit => 6).each do |user|
        user.microposts.create!(:content => Faker::Lorem.sentence(5), :no_of_vote => 0)
      end
    end

  end

  task :populateprod => :environment do
    Rake::Task['db:reset'].invoke

    admin = User.create!(:name => "Admin",
                         :email => "admin@liveq.com",
                         :password => "qwerty",
                         :password_confirmation => "qwerty")
    admin.toggle!(:admin)


  end
end
