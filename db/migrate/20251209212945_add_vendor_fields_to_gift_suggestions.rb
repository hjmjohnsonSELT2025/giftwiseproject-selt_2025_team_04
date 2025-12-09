class AddVendorFieldsToGiftSuggestions < ActiveRecord::Migration[7.1]
  def change
    add_column :gift_suggestions, :best_vendor_name, :string
    add_column :gift_suggestions, :best_vendor_url, :string
    add_column :gift_suggestions, :best_vendor_price, :decimal
  end
end
