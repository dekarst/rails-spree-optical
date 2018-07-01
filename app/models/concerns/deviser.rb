module Deviser
    extend ActiveSupport::Concern

    included do
        # :token_authenticatable, :confirmable, :lockable, :timeoutable
        devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
    end
end
