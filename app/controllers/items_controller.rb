class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :move_index, only: [:edit]
def index
  @items = Item.all.order("created_at DESC")
end 

def new
  @item = Item.new
end

def create
  @item = Item.new(item_params)
  if @item.save
    redirect_to root_path
  else
    render :new
  end
end

def show
end

def edit
end

def update
  if @item.update(item_params)
    redirect_to root_path
  else
    render :edit
  end
end

def destroy
  @item.destroy
  redirect_to root_path
end
private

  def item_params
    params.require(:item).permit(:name, :info, :category_id, :item_status_id, :delivery_charge_id, :prefecture_id, :shipping_day_id, :price, :image ).merge(user_id: current_user.id)
  end

  def move_index
    redirect_to root_path if @item.user.id != current_user.id
  end

  def find_item
    @item = Item.find(params[:id])
  end
end
