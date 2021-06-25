FactoryBot.define do
  factory :purchases_address do
    postal_code { '123-4567' }
    prefecture_id { 12 }
    city { '棘館市' }
    house_number { '1-1-1' }
    telephone_number { '05012345678' }
    building_name { 'テストビル50F' }
    #token { 'tok_9a01b13fefb7fd32b555f69730fc' }
  end
end