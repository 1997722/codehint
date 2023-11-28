FactoryBot.define do
  factory :post do
    content { 'コーディネートの説明' }

    association :user

    after(:build) do |post|
      post.image.attach(io: File.open('public/images/S__355590150.jpg'), filename: 'S__355590150.jpg')
    end
  end
end
