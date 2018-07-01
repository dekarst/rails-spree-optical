module ActiveRecord
    class Base
        class << self
            def prg_set(flash, model, opts={})
                opts.reverse_merge!(prg_name: "prg_#{prg_model_name}".to_sym, keep: false, add_fields: [], include_errors: :errors)
                opts[:prg_name] = opts[:prg_name].to_sym

                json_model = model.as_json[prg_model_name.to_s]
                json_model ||= model.as_json

                opts[:add_fields].each do |field|
                    json_model[field.to_s] = model.send(field)
                end

                json_model[opts[:include_errors]] = model.errors.messages if opts[:include_errors].present?

                flash["#{opts[:prg_name]}_keep".to_sym] = true if opts[:keep]
                flash[opts[:prg_name].to_sym] = json_model
            end

            def prg_set_collection(flash, collection, opts={})
                opts.reverse_merge!(prg_name: "prg_#{prg_model_name}".to_sym, keep: false, add_fields: [], include_errors: :errors)
                opts[:prg_name] = opts[:prg_name].to_sym

                models = []
                collection.each do |model|
                    json_model = model.as_json[prg_model_name.to_s]
                    json_model ||= model.as_json

                    opts[:add_fields].each do |field|
                        json_model[field.to_s] = model.send(field)
                    end

                    json_model[opts[:include_errors]] = model.errors.messages if opts[:include_errors].present?

                    models << json_model
                end

                flash["#{opts[:prg_name]}_keep".to_sym] = true if opts[:keep]
                flash[opts[:prg_name].to_sym] = models
            end

            def prg_get(flash, opts={})
                opts.reverse_merge!(prg_name: "prg_#{prg_model_name}".to_sym, include_errors: :errors)
                opts[:prg_name] = opts[:prg_name].to_sym

                if flash.key?(opts[:prg_name])
                    errors = flash[opts[:prg_name]].delete(opts[:include_errors]) if opts[:include_errors].present?

                    model = new(flash[opts[:prg_name]])
                    model.valid?

                    if opts[:include_errors]
                        errors.each do |k, v|
                            model.errors.messages[k] ||= []
                            model.errors.messages[k] << v
                            model.errors.messages[k].flatten!
                        end
                    end

                    flash.discard(opts[:prg_name])

                    if flash.key?("#{opts[:prg_name]}_keep".to_sym)
                        flash.discard("#{opts[:prg_name]}_keep".to_sym)

                        prg_set(flash, model)
                    end

                    return model
                end
            end

            def prg_get_collection(flash, opts={})
                opts.reverse_merge!(prg_name: "prg_#{prg_model_name}".to_sym, include_errors: :errors)
                opts[:prg_name] = opts[:prg_name].to_sym

                if flash.key?(opts[:prg_name])
                    errors = flash[opts[:prg_name]].delete(opts[:include_errors]) if opts[:include_errors].present?

                    models = []
                    flash[opts[:prg_name]].each do |model|
                        model = new(model)
                        model.valid?

                        if opts[:include_errors]
                            errors.each do |k, v|
                                model.errors.messages[k] ||= []
                                model.errors.messages[k] << v
                                model.errors.messages[k].flatten!
                            end
                        end

                        models << model
                    end

                    flash.discard(opts[:prg_name])

                    if flash.key?("#{opts[:prg_name]}_keep".to_sym)
                        flash.discard("#{opts[:prg_name]}_keep".to_sym)

                        prg_set_collection(flash, models)
                    end

                    return models
                end
            end

            def prg_model_name
                name.tableize.singularize.to_sym
            end
        end
    end
end

