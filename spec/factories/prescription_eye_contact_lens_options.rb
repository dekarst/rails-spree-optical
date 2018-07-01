# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :prescription_eye_contact_lens_option, :class => 'PrescriptionEyeContactLensOptions' do
    prescription_eye_id 1
    contact_lens_value ""
  end
end
