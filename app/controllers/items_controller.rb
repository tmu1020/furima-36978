class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]
  before_action :purchase_confirmation, only: [:edit, :update]

  def index
    @items = Item.all.order(created_at: :desc)
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
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path if @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(
      :image, :item_name, :description, :category_id, :condition_id,
      :shipping_cost_id, :prefecture_id, :shipping_day_id, :price
    ).merge(
      user_id: current_user.id
    )
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @item.user
  end

  def purchase_confirmation
    redirect_to root_path if @item.purchase_record.present?
  end
end
