# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :frame_variant_frame_option_type, :class => 'FrameVariantFrameOptionTypes' do
    position 1
    frame_variant_id 1
    frame_option_type_id 1
  end
end
