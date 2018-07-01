Spree::Admin::PagesController.class_eval do
    protected
        def collection
            return parent.send(controller_name) if parent_data.present?

            if model_class.respond_to?(:accessible_by) && !current_ability.has_block?(params[:action], model_class)
                model_class.accessible_by(current_ability, action).where('type IS NULL')
            else
                model_class.where('type IS NULL')
            end
        end
end
