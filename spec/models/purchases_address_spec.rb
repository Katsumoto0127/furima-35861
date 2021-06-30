require 'rails_helper'

RSpec.describe PurchasesAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_address = FactoryBot.build(:purchases_address, user_id: user.id, item_id: item.id)
    sleep 1
  end

  describe '購入処理' do
    context '購入できるとき' do
      it '正しく入力されていれば購入できる' do
        expect(@purchase_address).to be_valid
      end
      it '建物名が空でも登録できるとき' do
        @purchase_address.building_name = ""
        expect(@purchase_address).to be_valid
      end
    end

    context '購入できないとき' do
      it 'トークンが空では購入できない' do
        @purchase_address.token = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Token can't be blank"
      end
      it '郵便番号が空では購入できない' do
        @purchase_address.postal_code = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Postal code can't be blank", "Postal code is invalid. Include hyphen(-)"
      end
      it '郵便番号にハイフンがなかったら購入できない' do
        @purchase_address.postal_code = '1111111'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Postal code is invalid. Include hyphen(-)"
      end
      it '郵便番号が全角（ハイフンあり）では購入できない' do
        @purchase_address.postal_code = '１１１-１１１１'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Postal code is invalid. Include hyphen(-)"
      end
      it '郵便番号が全角(ハイフンなし)では購入できない' do
        @purchase_address.postal_code = '１１１１１１１'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Postal code is invalid. Include hyphen(-)"
      end
      it '都道府県が選択されていなければ購入できない' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Prefecture can't be blank"
      end
      it '市区町村が空だったら購入できない' do
        @purchase_address.city = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "City can't be blank"
      end
      it '番地が空だと購入できない' do
        @purchase_address.house_number = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "House number can't be blank"
      end
      it '電話番号が空だと購入できない' do
        @purchase_address.telephone_number = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Telephone number can't be blank", "Telephone number Phone number is invalid. Input only number"
      end
      it '電話番号が半角数字のみでないと購入できない' do
        @purchase_address.telephone_number = "123acf34h5d"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Telephone number Phone number is invalid. Input only number"
      end
      it '電話番号が全角数字だと購入できない' do
        @purchase_address.telephone_number = '１１１１１１１１１１１'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Telephone number Phone number is invalid. Input only number"
      end
      it '電話番号が9桁以下では購入できない' do
        @purchase_address.telephone_number = "11111"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Telephone number is too short (minimum is 10 characters)"
      end
      it '電話番号が12桁以上では購入できない' do
        @purchase_address.telephone_number = "1234567890987"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Telephone number is too long (maximum is 11 characters)"
      end
      it 'userが紐付いていないと購入できない' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "User can't be blank"
      end
      it 'itemが紐付いていないと購入できない' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Item can't be blank"
      end
    end
  end
end