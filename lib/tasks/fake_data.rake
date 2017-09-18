namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    make_users
    make_tags
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

  @users = User.all

  p 'Created Users'
end

def make_tags
  p 'Creating Tags'

  rand(10..20).times do
    Tag.create(name: Faker::Pokemon.name )
  end

  @tags = Tag.all

  p 'Created Tags'
end

def make_questions
  p 'Creating Questions'

  rand(10..20).times do
    question = Question.new(
        title: Faker::Lovecraft.sentence,
        content: Faker::Lovecraft.paragraph(2),
        user: @users.sample
    )
    add_tags(question)
    question.save

    add_comments(question)
    add_votes(question)
  end

  p 'Created Questions'
end

def add_tags(question)
  p 'Adding Tags'

  rand(1..5).times do
    question.tags << @tags.sample
  end

  p 'Added Tags'
end

def add_comments(question)
  p 'Creating Comments'

  rand(15..30).times do
    comment = Comment.create(
        content: Faker::RickAndMorty.quote,
        question: question,
        user: @users.sample
    )
    add_votes(comment)
  end

  p 'Created Comments'
end

def add_votes(votable)
  p 'Adding Votes'

  rand(1..@users.size).times do
    Vote.create(
        user: @users.sample,
        votable: votable,
        rating: rand(-1..1)
    )
  end

  p 'Added Votes'
end

