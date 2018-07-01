module Spree
    module Admin
        class UsersController < ResourceController
            def model_class
                User
            end
        end
    end
end
