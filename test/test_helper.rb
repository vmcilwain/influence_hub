ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require_relative 'support/authentication_helpers'
require_relative 'support/authorization_helpers'
require_relative 'support/integration_helpers'

module ActiveSupport
  class TestCase
    include FactoryBot::Syntax::Methods

    Shoulda::Matchers.configure do |config|
      config.integrate do |with|
        with.test_framework(:minitest)
        with.library(:rails)
      end
    end

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    # fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

class BaseIntegrationTest < ActionDispatch::IntegrationTest
  # devise test helpers are broken in rails 8
  # This is the workaround until it is fixed
  ActiveSupport.on_load(:action_mailer) do
    Rails.application.reload_routes_unless_loaded
  end

  include Devise::Test::IntegrationHelpers
  include ActionView::RecordIdentifier
  include ActionView::Helpers::DateHelper
  include Support::AuthenticationHelpers
  include Support::AuthorizationHelpers
  include Support::IntegrationHelpers
end

class BasePolicyTest < ActiveSupport::TestCase
  def assert_permit(user, record, action)
    assert(Pundit.policy(user, record).public_send("#{action}?"), "Expected #{user.inspect} to be permitted to #{action} #{record.inspect}")
  end

  def assert_forbid(user, record, action)
    assert_not(Pundit.policy(user, record).public_send("#{action}?"), "Expected #{user.inspect} to be forbidden from #{action} #{record.inspect}")
  end
end
