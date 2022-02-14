class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:id])
    if user_signed_in? && current_user.id != @item.user_id && @item.purchase_record == nil
      @purchase_address = PurchaseAddress.new
    else
      redirect_to root_path
    end
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_record_params)
    if @purchase_address.valid?
      # pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index
  end
end

private

def purchase_record_params
  params.require(:purchase_address).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number
  ).merge(
    item_id: params[:item_id],user_id: current_user.id
  )
end
