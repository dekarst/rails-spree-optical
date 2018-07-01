require 'spec_helper'

describe Spree::Admin::ContactLensCategoriesController do
    login_admin

    describe "'index'" do
        it "be successful" do
            spree_get :index

            expect(response).to be_success
        end
    end
end
