namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    make_users
    # make_tags
    make_questions
  end
end

def make_users
  p 'Creating Users'

  rand(10..20).times do
    User.create(
        email: Faker::Internet.email,
        login: Faker::RickAndMorty.character,
        password: '12345678',
        password_confirmation: '12345678'
    )
  end

  p 'Created Users'
end

# def make_tags
#   users = User.all
#   user  = users.first
#   followed_users = users[2..50]
#   followers      = users[3..40]
#   followed_users.each { |followed| user.follow!(followed) }
#   followers.each      { |follower| follower.follow!(user) }
# end

def make_questions
  p 'Creating Questions'

  users = User.all

  rand(10..20).times do
    question = Question.create(
        title: Faker::Lovecraft.sentence,
        content: Faker::Lovecraft.paragraph(2),
        user: users.sample
    )

    # add_tags(question)
    add_comments(question)
    add_votes(question)
  end

  p 'Created Questions'
end

# def add_tags(question)
#   users = User.all
#   user  = users.first
#   followed_users = users[2..50]
#   followers      = users[3..40]
#   followed_users.each { |followed| user.follow!(followed) }
#   followers.each      { |follower| follower.follow!(user) }
# end

def add_comments(question)
  p 'Creating Comments'

  users = User.all

  rand(15..30).times do
    comment = Comment.create(
        content: Faker::RickAndMorty.quote,
        question: question,
        user: users.sample
    )
    add_votes(comment)
  end

  p 'Created Comments'
end

def add_votes(votable)
  p 'Adding Votes'

  users = User.all

  rand(1..users.size).times do
    Vote.create(
        user: users.sample,
        votable: votable,
        rating: rand(-1..1)
    )
  end

  p 'Added Votes'
end

