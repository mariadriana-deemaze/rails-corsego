class AddStripeFieldsToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :stripe_product_id, :string
    add_column :courses, :stripe_price_id, :string
    add_column :courses, :currency, :string, default: 'eur'
  end
end
