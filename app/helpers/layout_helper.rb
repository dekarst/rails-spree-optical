module LayoutHelper
    def head
        render(partial: 'shared/head')
    end

    def header
        render(partial: 'shared/header')
    end

    def menu
        render(partial: 'shared/menu')
    end

    def footer
        render(partial: 'shared/footer')
    end

    def cart
        render(partial: 'shared/cart').html_safe
    end

    def push
        "<div id='push'></div>".html_safe
    end

    def icon_stack(icon)
        "<span class='icon-stack'><i class='icon-check-empty icon-stack-base'></i><i class='#{icon}'></i></span>".html_safe
    end

    def footer_toggler
        "<div class='footer-toggler'><a href='#'><span class='icon-stack'><i class='icon-sign-blank icon-stack-base'></i><i class='icon-arrow-up'></i></span></a></div>".html_safe
    end

    def clear
        "<div style='clear:both'></div>".html_safe
    end

    def breadcrumb
        render(partial: 'shared/breadcrumb')
    end
end
