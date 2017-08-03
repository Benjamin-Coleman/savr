# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/dsl'
require "rack_session_access/capybara"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
    DatabaseCleaner.strategy = :truncation
  config.after(:all) do
    DatabaseCleaner.clean
  end
    config.include Capybara::DSL
  config.include LoginHelper, :type => :feature
  config.before(:each) do
    @location1 = Location.create(address: '11 Broadway', city: 'NY', state: 'NY', zip_code: '11111')

    @ben = User.create(name: "Ben", password: 'dog', password_confirmation: 'dog')
    @tyler = User.create(name: "Tyler", password: 'dog', password_confirmation: 'dog')

    @listing1 = Listing.create(location_id: @location1.id, status: 'open', donator_id: @ben.id, title: 'Leftover Pizza')
    @listing2 = Listing.create(location_id: @location1.id, status: 'open', donator_id: @tyler.id, title: 'Chinese Food')
    @listing3 = Listing.create(location_id: @location1.id, status: 'open', donator_id: @ben.id, title: 'Leftover Poptart')

    @food1 = Food.create(name: 'Pizza', quantity: 3, cuisine: 'Italian', listing_id: 1, condition: 'new')
    @food2 = Food.create(name: 'Fried Rice', quantity: 1, cuisine: 'Chinese', listing_id: 2, condition: 'old')
    @food3 = Food.create(name: 'Poptart', quantity: 5, cuisine: 'American', listing_id: 3, condition: 'new')

    @bid1 = Bid.create(listing_id: 1, receiver_id: 2, completed: 'false')
    @bid2 = Bid.create(listing_id: 2, receiver_id: 1, completed: 'false')
    @bid3 = Bid.create(listing_id: 3, receiver_id: 2, completed: 'false')

  end
end

