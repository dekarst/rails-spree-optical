require 'spec_helper'

describe VariantsController do
    describe "'price'" do
        let!(:variant) {FactoryGirl.create(:product).master}

        it "be successful" do
            spree_get :price, id: variant.id, format: :json

            expect(response).to be_success
        end

        it "return the right price when quantity = 1" do
            spree_get :price, id: variant.id, quantity: 1, format: :json

            expect(response.body).to have_content(19.99)
        end

        it "return the right price when quantity = 2" do
            spree_get :price, id: variant.id, quantity: 2, format: :json

            expect(response.body).to have_content(39.98)
        end

        it "return the right price when quantity = 10" do
            spree_get :price, id: variant.id, quantity: 10, format: :json

            expect(response.body).to have_content(199.90)
        end
    end
end
