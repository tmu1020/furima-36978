require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id)
    end

    context '内容に問題がない場合' do
      it '全ての値が正しく入力されていれば保存できる' do
        expect(@purchase_address).to be_valid
      end
      it 'building_nameが空でも保存できる' do
        @purchase_address.building_name = ''
        expect(@purchase_address).to be_valid
      end
      it 'phone_numberが10桁でも保存できる' do
        @purchase_address.phone_number = '1234567890'
        expect(@purchase_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空では登録できない' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'post_codeが空だと保存できない' do
        @purchase_address.post_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeが半角のハイフンを含んだ形式でないと保存できない' do
        @purchase_address.post_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Post code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'prefectureが「---」では保存できない' do
        @purchase_address.prefecture_id = 0
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では保存できない' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空では保存できない' do
        @purchase_address.address = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空では保存できない' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが9桁以下では保存できない' do
        @purchase_address.phone_number = '123456789'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is too short')
      end
      it 'phone_numberが半角数字でないと保存できない' do
        @purchase_address.phone_number = '０９０１２３４５６７８'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_numberが整数でないと保存できない' do
        @purchase_address.phone_number = '090123456.7'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
    end
  end
end
