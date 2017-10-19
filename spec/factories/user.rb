FactoryGirl.define do  
   factory :user do
     name         { FFaker::NameBR.name }
     email        { FFaker::Internet.email }
     password     'secret123'
   end
end