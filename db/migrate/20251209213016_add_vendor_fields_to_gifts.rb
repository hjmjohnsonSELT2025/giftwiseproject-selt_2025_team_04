class AddVendorFieldsToGifts < ActiveRecord::Migration[7.1]
  def change
    add_column :gifts, :best_vendor_name, :string
    add_column :gifts, :best_vendor_url, :string
    add_column :gifts, :best_vendor_price, :decimal
  end
end
