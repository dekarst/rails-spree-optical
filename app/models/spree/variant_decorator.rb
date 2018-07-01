Spree::Variant.class_eval do
    belongs_to :frame_color
    has_one :default_retail_price,
        -> {where currency: Spree::Config[:currency]},
        class_name: 'RetailPrice',
        dependent: :destroy

    delegate_belongs_to :default_retail_price, :display_retail_price, :display_retail_amount, :retail_price, :retail_price=

    has_many :retail_prices, dependent: :destroy

    def color_and_options_text
        "#{color} | #{options_text}"
    end

    def color
        frame_color.try(:name)
    end

    def retail_price_in(currency)
        retail_prices.select {|retail_price| retail_price.currency == currency}.first || RetailPrice.new(variant_id: self.id, currency: currency)
    end

    def saved_price_in(currency)
        saved_amount = retail_price.present? ? (retail_price_in(currency).amount - price_in(currency).amount) : 0
        Spree::Price.new(variant_id: self.id, currency: currency, amount: saved_amount)
    end

    def complete_size
        "#{option_value('eye')}/#{option_value('bridge')}-#{option_value('temple')}"
    end
end
