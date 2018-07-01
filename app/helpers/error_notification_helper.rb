module ErrorNotificationHelper
    def build_error_notification_message(object, message="", error_fields=[])
        error_notification_message = message

        error_fields.each do |error_field|
            error_notification_message << "<br />#{object.errors[error_field].join('<br />')}" if object.errors.has_key?(error_field)
        end

        error_notification_message
    end
end
