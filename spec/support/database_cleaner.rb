RSpec.configure do |configure|
  configure.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  configure.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  configure.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end
  configure.before(:each) do
    DatabaseCleaner.start
  end

  configure.after(:each) do
    DatabaseCleaner.clean
  end
end