require 'rails_helper'

RSpec.describe Sale, type: :model do
    context 'validations' do
      it 'is valid with valid attributes' do
        sale = Sale.new(
          purchase_name: 'Example Purchase',
          item_description: 'Example Item',
          item_price: 10,
          purchase_count: 2,
          merchant_address: 'Example Address',
          merchant_name: 'Example Merchant',
          company: Company.new(name: 'Example Company', amount: 100.0)
        )
        expect(sale).to be_valid
      end
  
      it 'is invalid without a purchase name' do
        sale = Sale.new(purchase_name: nil)
        expect(sale).to be_invalid
        expect(sale.errors[:purchase_name]).to be_present
      end

      it 'is invalid without a merchant name' do
        sale = Sale.new(merchant_name: nil)
        expect(sale).to be_invalid
        expect(sale.errors[:merchant_name]).to be_present
      end
    end
  end