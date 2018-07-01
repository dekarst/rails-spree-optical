# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :content_best_brands_reference_content, :class => 'Content::BestBrandsReferenceContent' do
    brand_name "MyString"
    image "MyString"
    url "MyString"
  end
end
