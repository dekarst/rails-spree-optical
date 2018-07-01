Spree::CreditCard.class_eval do
    def expiry=(expiry)
        self[:month], self[:year] = expiry.gsub(/\ /, '').split('/')
        self[:year] = '20' + self[:year]
    end
end
