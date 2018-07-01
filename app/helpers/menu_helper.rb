module MenuHelper
    def header_menu(options={})
        render_menu Menu.find(1).menu_items, options
    end

    def footer_menu(options={})
        render_menu Menu.find(2).menu_items, options
    end

    private
        def render_menu(collection, options)
            content_tag :ul, options[:ul] do
                capture do
                    collection.each do |menu_item|
                        options = menu_item.link.starts_with?('http') ? {target: '_blank'} : {}
                        concat content_tag(:li, link_to(menu_item.content, menu_item.link, options), class: 'not')
                    end
                end
            end
        end
end
