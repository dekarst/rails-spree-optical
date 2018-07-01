class PrescriptionLensRule < ActiveRecord::Base
    belongs_to :prescription_item

    validates :prescription_item, :operation, :value, presence: true
    validates :operation, inclusion: {in: %w(= != > >= < <=)}
    validates :complementary_operation, inclusion: {in: %w(> >= < <=)}, if: Proc.new {complementary_operation.present?}
    validates :value, presence: true, if: Proc.new {complementary_operation.present?}

    def allowed_value?(v)
        return false unless valid?

        if single_operation?
            v.to_f.send(operation_as_sym, value.to_f)
        else
            v.to_f.send(operation_as_sym, value.to_f) and v.to_f.send(complementary_operation_as_sym, complementary_value.to_f)
        end
    end

    def display
        display_text = "#{prescription_item.try(:name_to_display)} #{operation} #{value}"
        display_text << " AND #{complementary_operation} #{complementary_value}" unless single_operation?

        display_text
    end

    private
        def operation_as_sym
            operation == '=' ? :'==' : operation.to_sym
        end

        def complementary_operation_as_sym
            complementary_operation.to_sym
        end

        def single_operation?
            operation == '=' or operation == '!=' or complementary_operation.nil?
        end
end
