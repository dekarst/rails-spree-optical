class LensType < ActiveRecord::Base
    has_many :lenses, dependent: :restrict_with_exception

    validates :name, presence: true, uniqueness: true
end
