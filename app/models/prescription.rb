class Prescription < ActiveRecord::Base
    belongs_to :order, class_name: 'Spree::Order'
    belongs_to :prescriptionable, polymorphic: true
    has_many :prescription_eyes, dependent: :destroy

    alias_attribute :eyes, :prescription_eyes

    delegate :user, to: :order

    validates :order, :prescriptionable, :prescription_eyes, :chosen_method, presence: true
    validates :prescription_eyes, length: {minimum: 2, maximum: 2}
    validates :chosen_method, inclusion: {in: [1, 2, 3]}
    validate :should_check_at_least_one_eye

    accepts_nested_attributes_for :prescription_eyes

    after_initialize :build_eyes

    mount_uploader :scanned_document, ScannedDocumentUploader

    def set_prescription_category(prescription_category)
        eyes.each do |eye|
            eye.prescription_category = prescription_category
        end
    end

    def left_eye
        eyes.select {|e| e.name == 'left'}.first
    end

    def right_eye
        eyes.select {|e| e.name == 'right'}.first
    end

    def lenses
        prescriptionable.product.lenses
    end

    def checked_eyes
        eyes.where(checked: true)
    end

    private
        def build_eyes
            self.eyes.build(name: 'right') if right_eye.nil?
            self.eyes.build(name: 'left') if left_eye.nil?
        end

        def should_check_at_least_one_eye
            errors.add(:base, "Should select at least one eye") unless eyes.any? {|e| e.checked?}
        end
end
