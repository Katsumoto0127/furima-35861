require 'rails_helper'

RSpec.describe Item, type: :model do
before do
  @item = FactoryBot.build(:item)
end

context '商品出品ができるとき' do
    it '正しく入力出来ていれば登録出来る' do
      expect(@item).to be_valid
    end
  end

  context '商品出品が出来ないとき' do
    it '画像が空では登録できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Image can't be blank"
    end
    it '商品名が空では登録出来ない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Name can't be blank"
    end
    it '商品説明が空では登録できない' do
      @item.info = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Info can't be blank"
    end
    it 'categiry_idが1だったら登録できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include 'Category must be other than 1'
    end
    it 'itemstatus_idが1だったら登録できない' do
      @item.item_status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include 'Item status must be other than 1'
    end
    it 'deliverycharge_idがだったら登録できない' do
      @item.delivery_charge_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include 'Delivery charge must be other than 1'
    end
    it 'prefecture_idが1だったら登録できない' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include 'Prefecture must be other than 1'
    end
    it 'shippingday_idが1だったら登録できない' do
      @item.shipping_day_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include 'Shipping day must be other than 1'
    end
    it '価格が空では登録できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Price can't be blank"
    end
    it '価格が300円以下では登録できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include 'Price is invalid'
    end
    it '価格が9999999円以上では登録できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include 'Price is invalid'
    end
    it '価格が全角数字では登録' do
      @item.price = '１０００００'
      @item.valid?
      expect(@item.errors.full_messages).to include 'Price is invalid'
    end
    it '価格が英数字混合では登録できない' do
      @item.price = '123abc'
      @item.valid?
      expect(@item.errors.full_messages).to include 'Price is invalid'
    end
  end
end
