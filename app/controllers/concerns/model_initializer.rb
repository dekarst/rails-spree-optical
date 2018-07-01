module ModelInitializer
    extend ActiveSupport::Concern

    included do
        before_filter :find_model, only: [:show, :edit, :update, :destroy]
        before_filter :new_model, only: :new
        before_filter :all_models, only: :index
    end

    private
        def find_model
            unless admin?
                if model_initializer_class.present?
                    if params.has_key?(:id)
                        model = model_initializer_class.find_by_permalink(params[:id]) if model_initializer_class.respond_to?(:find_by_permalink)
                        model ||= model_initializer_class.find_by_id(params[:id])

                        instance_variable_set("@#{model_initializer_name}", model) if model.present?
                    end
                end
            end
        end

        def new_model
            unless admin?
                instance_variable_set("@#{model_initializer_name}", model_initializer_class.new) if model_initializer_class.present?
            end
        end

        def all_models
            unless admin?
                instance_variable_set("@#{model_initializer_name_plural}", model_initializer_class.all) if model_initializer_class.present?
            end
        end

        def model_initializer_class
            begin
                controller_path.classify.constantize
            rescue NameError
                nil
            end
        end

        def model_initializer_name
            controller_name.classify.downcase
        end

        def model_initializer_name_plural
            controller_name.downcase
        end

        def admin?
            self.class.parent == Spree::Admin
        end
end
