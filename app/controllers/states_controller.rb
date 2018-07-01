class StatesController < ActionController::Base
    before_filter :load_country, only: :index

    def index
        @states = @country.states

        render json: render_to_string(partial: 'states').to_json
    end

    private
        def load_country
            @country = Spree::Country.find(params[:country_id])
        end
end
