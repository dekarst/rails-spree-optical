class PermittedParams < Struct.new(:params, :user)
    def registration
        params.require(:user).permit(*registration_attributes)
    end

    def registration_attributes
        if user.nil?
            [:email, :password]
        else
            [:password]
        end
    end

    def session
        begin
            params.require(:user).permit(:login, :password, :remember_me)
        rescue ActionController::ParameterMissing
        end
    end

    def contact
        params.require(:contact).permit(:name, :email, :phone, :subject, :comment)
    end
end
