module Devisable
    extend ActiveSupport::Concern

    included do
        before_filter :store_previous_url
    end

    def store_previous_url
        if allowed_path? && !request.xhr?
            if request.format == 'text/html' || request.content_type == 'text/html'
                session[:previous_url] = request.fullpath
                session[:last_request_time] = Time.now.utc.to_i
            end
        end
    end

    def after_sign_in_path_for(resource)
        previous_url
    end

    def after_update_path_for(resource)
        previous_url
    end

    def after_sign_out_path_for(resource)
        previous_url
    end

    private
        def previous_url
            if session.has_key?(:last_request_time) and (Time.now.utc.to_i - session[:last_request_time]) < 1.hour
                session[:previous_url] || root_path
            else
                root_path
            end
        end

        def allowed_path?
            ['/users', '/users/sign_in', '/users/sign_up', '/users/password', '/users/sign_out'].each do |path|
                return false if request.fullpath.ends_with?(path)
            end

            return true
        end
end
