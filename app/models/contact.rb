class Contact < ActiveRecord::Base
    belongs_to :user

    validates :name, :email, :phone, :subject, :comment, presence: true
    validates_associated :user
end
