FactoryGirl.define do

  factory :chat, :class => Chat do
    expedition { create(:expedition) }
  end

end
