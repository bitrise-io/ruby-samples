ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all
  end
end

# Mixin for tests that use Mongoid — clears all MongoDB collections before each test's setup runs.
module MongoidTestHelper
  def before_setup
    Mongoid.purge!
    super
  end
end
