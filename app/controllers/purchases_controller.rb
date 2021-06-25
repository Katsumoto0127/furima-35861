class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @purchases = PurchasesAddress.new
  end

  def create
    @purchases = PurchasesAddress.new(purchases_params)
    if @purchases.valid?
      @purchases.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def purchases_params
    @item = Item.find(params[:item_id])
    params.require(:purchases_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone_number).merge(user_id: current_user.id, item_id: @item.id)
  end
end
