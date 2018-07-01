FactoryGirl.define do
    factory :user do
        email
        password
    end

    factory :admin, parent: :user do
        after :create do |user|
            user.spree_roles << Spree::Role.find_or_create_by(name: 'admin')
        end
    end
end
