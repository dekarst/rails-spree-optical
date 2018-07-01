class UsersController < ApplicationController
    before_filter :authenticate_user!

    def dashboard
    end

    def orders
    end

    def reviews
    end

    def wishlist
    end
end
