class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
    @amount = Item.count
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end