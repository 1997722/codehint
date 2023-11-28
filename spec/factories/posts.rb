FactoryBot.define do
  factory :post do
    content { 'コーディネートの説明' }

    association :user

    after(:build) do |post|
      post.image.attach(io: File.open('public/images/S__355590150.jpg'), filename: 'S__355590150.jpg')
    end
    
    after(:create) do |post|
      create_list(:post_tag, 1, post: post, tag: create(:tag))
    end
  end
end
