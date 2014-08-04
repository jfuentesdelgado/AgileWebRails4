class CombineItemsInCart < ActiveRecord::Migration
	def up
  	#remplazar multiple lineas por una con la cantidad
  	Cart.all.each do |cart|
  		#contar el numero de cada producto en un carro
  		sums=cart.line_items.group(:product_id).sum(:quantity)

  		sums.each do |product_id, quantity|
  			if quantity > 1
  				#eliminar las lineas individuales
  				cart.line_items.where(product_id:product_id).delete_all
  				#remplazar con una sola linea
  				item = cart.line_items.build(product_id:product_id)
  				item.quantity = quantity
  				item.save!
  			end
  		end
  	end
  end 

  def down
  	#separar las lineas con cantidad mayor a uno en varias lineas
  	LineItem.where("quantity>1").each do |line_item|
  		#añadir lineas individuales
  		line_item.quantity.times do
  			LineItem.create cart_id:line_item.cart_id,product_id:line_item.product_id, quantity:1
  		end
  		#borra la linea original
  		line_item.destroy
  	end
	end
end