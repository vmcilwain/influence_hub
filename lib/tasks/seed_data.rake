namespace :seed do
  # bundle exec rake "seed:add_users[<count>]"
  desc 'Add specified number of users'
  task :add_users, [:count] => :environment do |_t, args|
    count = (args[:count] || 1).to_i
    
    puts "Creating #{count} user(s)..."
    
    begin
      count.times do
        user = FactoryBot.create(:user)
        puts "Created user: #{user.email}"
      end
      
      puts "\nSuccessfully created #{count} user(s)"
    rescue => e
      puts "Error creating users: #{e.message}"
      raise e
    end
  end

  # bundle exec rake "seed:add_organizations[<user_id>, <count>]"
  desc 'Add specified number of organizations'
  task :add_organizations, %i[user_id count] => :environment do |_t, args|
    count = (args[:count] || 1).to_i
    user = User.find(args[:user_id] || User.first.id)
    
    puts "Creating #{count} organization(s) for user #{user.email}..."
    
    begin
      count.times do
        org = FactoryBot.create(:organization, user: user)
        puts "Created organization: #{org.name}"
      end
      
      puts "\nSuccessfully created #{count} organization(s)"
    rescue => e
      puts "Error creating organizations: #{e.message}"
      raise e
    end
  end

  # bundle exec rake "seed:add_contacts[<org_id>, <count>]"
  desc 'Add specified number of contacts to an organization'
  task :add_contacts, %i[org_id count] => :environment do |_t, args|
    count = (args[:count] || 1).to_i
    org = Organization.find(args[:org_id] || Organization.first.id)
    
    puts "Creating #{count} contact(s) for organization #{org.name}..."
    
    begin
      count.times do
        contact = FactoryBot.create(:contact, organization: org, email: "contact-#{SecureRandom.hex(4)}@example.com")
        puts "Created contact: #{contact.email}"
      end
      
      puts "\nSuccessfully created #{count} contact(s)"
    rescue => e
      puts "Error creating contacts: #{e.message}"
      raise e
    end
  end

  # bundle exec rake "seed:add_campaigns[<user_id>, <count>]"
  desc 'Add specified number of campaigns'
  task :add_campaigns, %i[user_id count] => :environment do |_t, args|
    count = (args[:count] || 1).to_i
    user = User.find(args[:user_id] || User.first.id)
    
    puts "Creating #{count} campaign(s) for user #{user.email}..."
    
    begin
      count.times do
        campaign = FactoryBot.create(:campaign, user: user)
        puts "Created campaign: #{campaign.name}"
      end
      
      puts "\nSuccessfully created #{count} campaign(s)"
    rescue => e
      puts "Error creating campaigns: #{e.message}"
      raise e
    end
  end

  # bundle exec rake "seed:add_tasks[<campaign_id>, <count>]"
  desc 'Add specified number of tasks to a campaign'
  task :add_tasks, %i[campaign_id count] => :environment do |_t, args|
    count = (args[:count] || 1).to_i
    campaign = Campaign.find(args[:campaign_id] || Campaign.first.id)
    user = campaign.user
    
    puts "Creating #{count} task(s) for campaign #{campaign.name} for user #{user.email}..."
    
    begin
      count.times do
        task = FactoryBot.create(:task, campaign: campaign, user: user)
        puts "Created task: #{task.description}"
      end
      
      puts "\nSuccessfully created #{count} task(s)"
    rescue => e
      puts "Error creating tasks: #{e.message}"
      raise e
    end
  end

  # bundle exec rake "seed:build_full_campaigns[<user_id>, <count>]"
  desc 'build full campaign'
  task :build_full_campaigns, %i[user_id, count] => :environment do |_t, args|
    count = (args[:count] || 1).to_i
    user = User.find(args[:user_id] || User.first.id)
    
    puts "Creating #{count} campaign(s) for user #{user.email}..."
    
    begin
      count.times do
        campaign = FactoryBot.create(:campaign, user: user)
        puts "Created campaign: #{campaign.name}"
        
        count.times do
          task = FactoryBot.create(:task, campaign: campaign, user: user)
          puts "Created task: #{task.description}"
        end

        count.times do
          organization = FactoryBot.create(:organization, user: user)
          puts "Created organization: #{organization.name}"
          
          count.times do
            contact = FactoryBot.create(:contact, organization: organization, email: "contact-#{SecureRandom.hex(4)}@example.com")
            puts "Created contact: #{contact.email}"
          end
          
          Promotion.create!(campaign: campaign, organization: organization)
        end
      end

      puts "\nSuccessfully created #{count} campaign(s)"
    rescue => e
      puts "Error creating campaigns: #{e.message}"
      raise e
    end
  end
end
