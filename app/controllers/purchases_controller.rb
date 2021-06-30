class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item, only:[:index, :create]
  before_action :move_index
  before_action :sold_out, only:[:index, :create]
  def index
    @purchases = PurchasesAddress.new
  end

  def create
    @purchases = PurchasesAddress.new(purchases_params)
    if @purchases.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
      Payjp::Charge.create(
        amount: @item.price,
        card: purchases_params[:token],
        currency: 'jpy'
      )
      @purchases.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def purchases_params
    @item = Item.find(params[:item_id])

    params.require(:purchases_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def move_index
    @item = Item.find(params[:item_id])
    redirect_to root_path if @item.user_id == current_user.id
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def sold_out
    redirect_to root_path unless @item.purchase.nil?
  end
end
