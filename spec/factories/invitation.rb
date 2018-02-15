FactoryGirl.define do
  factory :invitation do
    team
    user { team.user }
    guest { create(:user) }
  end
end