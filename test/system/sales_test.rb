require "application_system_test_case"

class SalesTest < ApplicationSystemTestCase
  setup do
    @sale = sales(:one)
  end

  test "visiting the index" do
    visit sales_url
    assert_selector "h1", text: "Sales"
  end

  test "should create sale" do
    visit sales_url
    click_on "New sale"

    fill_in "Company", with: @sale.company_id
    fill_in "Item description", with: @sale.item_description
    fill_in "Item price", with: @sale.item_price
    fill_in "Merchant address", with: @sale.merchant_address
    fill_in "Merchant name", with: @sale.merchant_name
    fill_in "Purchase count", with: @sale.purchase_count
    fill_in "Purchase name", with: @sale.purchase_name
    click_on "Create Sale"

    assert_text "Sale was successfully created"
    click_on "Back"
  end

  test "should update Sale" do
    visit sale_url(@sale)
    click_on "Edit this sale", match: :first

    fill_in "Company", with: @sale.company_id
    fill_in "Item description", with: @sale.item_description
    fill_in "Item price", with: @sale.item_price
    fill_in "Merchant address", with: @sale.merchant_address
    fill_in "Merchant name", with: @sale.merchant_name
    fill_in "Purchase count", with: @sale.purchase_count
    fill_in "Purchase name", with: @sale.purchase_name
    click_on "Update Sale"

    assert_text "Sale was successfully updated"
    click_on "Back"
  end

  test "should destroy Sale" do
    visit sale_url(@sale)
    click_on "Destroy this sale", match: :first

    assert_text "Sale was successfully destroyed"
  end
end
