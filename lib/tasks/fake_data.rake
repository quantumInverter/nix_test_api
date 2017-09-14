namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # make_users
    # make_tags
    # make_questions
  end
end

def make_users
end

def make_tags
  # users = User.all
  # user  = users.first
  # followed_users = users[2..50]
  # followers      = users[3..40]
  # followed_users.each { |followed| user.follow!(followed) }
  # followers.each      { |follower| follower.follow!(user) }
end

def make_questions
  #users = User.all(limit: 6)
  #50.times do
  #  content = Faker::Lorem.sentence(5)
  #  users.each { |user| user.posts.create!(content: content) }
  #end
  # add_tags
  # add_comments
  # add_votes
end

def add_tags
  # users = User.all
  # user  = users.first
  # followed_users = users[2..50]
  # followers      = users[3..40]
  # followed_users.each { |followed| user.follow!(followed) }
  # followers.each      { |follower| follower.follow!(user) }
end

def add_comments
  # users = User.all
  # user  = users.first
  # followed_users = users[2..50]
  # followers      = users[3..40]
  # followed_users.each { |followed| user.follow!(followed) }
  # followers.each      { |follower| follower.follow!(user) }
  # add votes
end

def add_votes
  # users = User.all
  # user  = users.first
  # followed_users = users[2..50]
  # followers      = users[3..40]
  # followed_users.each { |followed| user.follow!(followed) }
  # followers.each      { |follower| follower.follow!(user) }
end

