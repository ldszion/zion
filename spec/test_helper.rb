ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include SessionHelper
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def log_in_as_admin
    log_in User.first
  end

  # Returns a string explaining why the record is not valid
  def why_is_not_valid(record)
    "#{record.class.name} is not valid because of: #{record.errors.full_messages.inspect}"
  end
end
