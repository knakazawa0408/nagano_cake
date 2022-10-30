class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses= Address.all
  end

  def confirm
    @cart_items = current_customer.cart_items
    @total = 0
    @postage = 800
    params[:order][:payment_method] = params[:order][:payment_method].to_i
    @order = Order.new(order_params)
    if params[:order][:address_id] == "0"
      @order.shipping_postal_code = current_customer.postal_code
      @order.shipping_address = current_customer.address
      @order.shipping_name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:address_id] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.shipping_postal_code = @address.postal_code
      @order.shipping_address = @address.address
      @order.shipping_name = @address.name
    elsif params[:order][:address_id] == "2"
      @order.shipping_postal_code = params[:order][:shipping_postal_code]
      @order.shipping_address = params[:order][:shipping_address]
      @order.shipping_name = params[:order][:shipping_name]
    end
    # binding.pry
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item| #カートの商品を1つずつ取り出しループ
      @order_detail = OrderDetail.new #初期化宣言
      @order_detail.item_id = cart_item.item_id #商品idを注文商品idに代入
      @order_detail.amount = cart_item.amount #商品の個数を注文商品の個数に代入
      @order_detail.total_price = cart_item.item.price #消費税込みに計算して代入
      @order_detail.order_id =  @order.id #注文商品に注文idを紐付け
      @order_detail.save #注文商品を保存
    end #ループ終わり

    current_customer.cart_items.destroy_all #カートの中身を削除
    redirect_to public_complete_path #thanksに遷移

  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :shipping_postal_code, :shipping_address, :shipping_name, :postage, :billing_amount)
  end
end
