# require 'debugger'

class AddPriceToLineItems < ActiveRecord::Migration
  def change
  	add_column :line_items, :price, :decimal,  precision: 8, scale: 2

  	LineItem.all.each do |line|
  		# debugger
  		line.price = Product.find_by(id: line.product_id).price
  		line.save!
  	end
  end
end
