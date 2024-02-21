
5.times do |i|
  team = Team.create!(name: Faker::Company.name, subdomain: "team#{i}")

  ActsAsTenant.current_tenant = team

  5.times do
    team.users.create!(name: Faker::Name.name, email: Faker::Internet.email, role: (rand > 0.7 ? 'salesmanager' : 'salesperson'))
  end

  20.times do
    team.contacts.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      team: team
    )
  end

  (rand(8) + 1).times do
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
