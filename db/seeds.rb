
5.times do
  team = Team.create!(name: Faker::Company.name)

  5.times do
    team.users.create!(name: Faker::Name.name, email: Faker::Internet.email)
  end

  20.times do
    team.contacts.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      team: team
    )
  end

  rand(8).times do
    opportunity = team.opportunities.create!(
      name: Faker::Company.name,
      status: ['open', 'won', 'lost'].sample,
      user: team.users.sample
    )

    rand(5).times do
      opportunity.opportunity_contacts.create!(
        contact: team.contacts.sample,
        team: team
      )
    end
  end
end
