class Menu < ActiveRecord::Base
    has_many :menu_items, ->{order :position}, dependent: :destroy

    validates :name, presence: true, uniqueness: true
end
