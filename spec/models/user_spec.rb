require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録' do
    context '新規登録できるとき' do
    it '正しく入力出来ていれば登録できる' do
      expect(@user).to be_valid
    end
    it 'passwordとpassword_confirmationが6文字以上の半角英数字であれば登録できる' do
      @user.password = 'testtest123456789'
      @user.password_confirmation = 'testtest123456789'
      expect(@user).to be_valid
    end
  end

  context '新規登録出来ないとき' do
    it 'nicknameが空だと登録出来ない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end
    it 'emailが空だと登録出来ない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it 'emailが重複したら登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include 'Email has already been taken'
    end
    it 'emailに@がないと登録できない' do
      @user.email = 'testtest'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Email is invalid'
    end
    it 'passwordが空だと登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    it 'passwordが存在してもpassword_confirmationが空では登録できない' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
    it 'passwordが6文字以下では登録できない' do
      @user.password = 'ab12'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
    end
    it 'passwordは半角英数字でないと登録できない' do
      @user.password = '111111111'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
    it 'passwordは半角英語のみだと登録できない' do
      @user.password = 'abjfeinengenu'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password is invalid. Input half-width alphanumeric characters.'
    end
    it 'passwordは全角英数字混合だと登録できない' do
      @user.password = '１２３４ａｂｃd'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password is invalid. Input half-width alphanumeric characters.'
    end
    it 'last_nameが空だと登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end
    it 'last_nameは全角（漢字・ひらがな・カタカナ）でないと登録できない' do
      @user.last_name = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Last name is invalid. Input full-width characters.'
    end
    it 'first_nameが空だと登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end
    it 'first_nameは全角（漢字・ひらがな・カタカナ）でないと登録できない' do
      @user.first_name = 'ﾃｽﾄ'
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name is invalid. Input full-width characters.'
    end
    it 'last_name_kanaが空だと登録できない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name kana can't be blank"
    end
    it 'last_name_kanaは全角（カタカナ）でないと登録できない' do
      @user.last_name_kana = 'ああああああ'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Last name kana is invalid. Input full-width katakana characters.'
    end
    it 'last_kana_nameは半角だと登録できない' do
      @user.last_name_kana = 'ﾃｽﾄﾃｽﾄ'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Last name kana is invalid. Input full-width katakana characters.'
    end
    it 'first_name_kanaが空だと登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "First name kana can't be blank"
    end
    it 'first_name_kanaは全角（カタカナ）でないと登録できない' do
      @user.first_name_kana = 'ああああああ'
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name kana is invalid. Input full-width katakana characters.'
    end
    it 'first_name_kanaは半角だと登録できない' do
      @user.first_name_kana = 'ﾃｽﾄﾃｽﾄ'
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name kana is invalid. Input full-width katakana characters.'
    end
    it 'birth_dateが空だと登録できない' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Birth date can't be blank"
    end
  end
 end
end
