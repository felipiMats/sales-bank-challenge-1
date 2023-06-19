class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.decimal :amount, precision: 10, scale: 2, default: 0.00

      t.timestamps
    end
  end
end
