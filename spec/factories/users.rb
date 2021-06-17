FactoryBot.define do
  factory :user do
    nickname { 'テスト' }
    email { Faker::Internet.free_email }
    password { 'step1234' }
    password_confirmation { password }
    last_name { 'てすと' }
    first_name { 'てすと' }
    last_name_kana { 'テスト' }
    first_name_kana { 'テスト' }
    birth_date { '1970-04-03' }
  end
end