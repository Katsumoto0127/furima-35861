class ItemsController < ApplicationController

def index
end

private

def item_params
  params.require(:item).permit(:name, :info, :category_id, :itemstatus_id, :deliverycharge_id, :prefecture_id, :shippingday_id, :price).merge(user_id: current_user.id)
end
