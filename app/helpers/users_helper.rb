module UsersHelper
    def user_settings_item(label, path, starts_with_paths=[])
        klass = request.fullpath == path ? 'active' : ''
        if starts_with_paths.any? and klass == ''
            starts_with_paths.each do |starts_with_path|
                klass = 'active' and break if request.fullpath.starts_with?(starts_with_path)
            end
        end

        content_tag :li, link_to(label, path, class: klass)
    end
end
