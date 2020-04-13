RSpec.configure do |config|
  include Warden::Test::Helpers
  config.after :each do
    Warden.test_reset!
  end
end
