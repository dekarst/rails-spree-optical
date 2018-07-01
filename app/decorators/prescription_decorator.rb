class PrescriptionDecorator < Draper::Decorator
    delegate_all

    def presentation
        t = ''

        checked_eyes.each do |eye|
            t << eye.pretty_name
        end

        t
    end
end
