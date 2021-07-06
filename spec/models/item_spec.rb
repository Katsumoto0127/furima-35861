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
      expect(@item.errors.full_messages).to include "画像を入力してください"
    end
    it '商品名が空では登録出来ない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "商品名を入力してください"
    end
    it '商品説明が空では登録できない' do
      @item.info = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "商品の説明を入力してください"
    end
    it 'categiry_idが1だったら登録できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "カテゴリーは -- 以外を選択してください"
    end
    it 'itemstatus_idが1だったら登録できない' do
      @item.item_status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "商品の状態は -- 以外を選択してください"
    end
    it 'deliverycharge_idがだったら登録できない' do
      @item.delivery_charge_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "配送料の負担は -- 以外を選択してください"
    end
    it 'prefecture_idが1だったら登録できない' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "発送元の地域は -- 以外を選択してください"
    end
    it 'shippingday_idが1だったら登録できない' do
      @item.shipping_day_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "発送までの日数は -- 以外を選択してください"
    end
    it '価格が空では登録できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "価格を入力してください", "価格無効です。"
    end
    it '価格が300円以下では登録できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include "価格無効です。"
    end
    it '価格が9999999円以上では登録できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include "価格無効です。"
    end
    it '価格が全角数字では登録' do
      @item.price = '１０００００'
      @item.valid?
      expect(@item.errors.full_messages).to include "価格無効です。"
    end
    it '価格が英数字混合では登録できない' do
      @item.price = '123abc'
      @item.valid?
      expect(@item.errors.full_messages).to include "価格無効です。"
    end
    it 'userが紐付いていないと登録できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Userを入力してください"
    end
  end
end
