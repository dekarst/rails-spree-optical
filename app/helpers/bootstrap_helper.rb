module BootstrapHelper
    ALERT_TYPES = [:error, :danger, :info, :success, :warning]

    def bootstrap_flash
        flash_messages = []
        flash.each do |type, message|
            # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
            next if message.blank?

            type = :success if type == :notice
            type = :error   if type == :alert
            type = :danger   if type == :error
            next unless ALERT_TYPES.include?(type)

            Array(message).each do |msg|
                text = content_for(:javascript, "<script type='text/javascript'>$('#flash-container').messenger().post({message: \"#{msg.gsub(/\n/, '<br/>')}\", type: '#{type}', showCloseButton: true});</script>".html_safe)
                flash_messages << text if message
            end
        end

        flash_messages.join.html_safe
    end
end
