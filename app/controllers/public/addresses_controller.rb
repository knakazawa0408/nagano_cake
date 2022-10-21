class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = Address.where(customer_id: current_customer.id).includes(:customer).order("created_at DESC")
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    address = Address.new(address_params)
    address.customer_id = current_customer.id
    address.save
    redirect_to public_addresses_path
  end

  def update
    address = Address.find(params[:id])
    address.update(address_params)
    redirect_to public_addresses_path
  end

  def destroy
  end

  private
    def address_params
        params.require(:address).permit(:customer_id, :name, :postal_code, :address)
    end
end
