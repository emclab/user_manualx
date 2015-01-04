# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_manualx_manual, :class => 'UserManualx::Manual' do
    subject "MyString"
    content "MyText"
    category_id 1
    sub_category_id 1
    last_updated_by_id 1
    submited_by_id 1
  end
end
