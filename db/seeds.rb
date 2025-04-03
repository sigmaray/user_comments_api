if !Rails.env.test? && User.count == 0
  100.times.each do
    user = User.create!(
      username: Faker::Internet.unique.username(specifier: 5..10),
      email: Faker::Internet.unique.email,
      password: Faker::Lorem.word
    )
    5.times.each do
      Comment.create!(
        user: user,
        content: Faker::Lorem.paragraph(sentence_count: rand(1..5))
      )
    end
  end
end
