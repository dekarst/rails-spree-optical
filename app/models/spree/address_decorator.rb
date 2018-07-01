Spree::Address.class_eval do
    belongs_to :user

    validates_associated :user
end
