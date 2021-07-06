class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items

      PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
      with_options presence: true do
      validates :nickname
      # passwordに半角英数字だけ許可
      validates_format_of :password, with: PASSWORD_REGEX, message: '無効です。半角英数字で入力してください', if: :password_required?
      validates :birth_date
      end

      # ひらがな、カタカナ、漢字のみ許可する
      with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '無効です。ひらがな、カタカナ、漢字で入力してください' } do
      validates :last_name
      validates :first_name
      end

      # カタカナのみ許可する
      with_options presence: true, format: { with: /\A[ァ-ヶ一]+\z/, message: '無効です。カタカナで入力してください。' } do
      validates :last_name_kana
      validates :first_name_kana
      end
end

