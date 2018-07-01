include Warden::Test::Helpers

module FeatureHelpers
    def login(opts={})
        user = FactoryGirl.create(:user, opts)
        login_as user, scope: :user
        user
    end
end

RSpec.configure do |config|
    config.include FeatureHelpers, type: :feature
end
