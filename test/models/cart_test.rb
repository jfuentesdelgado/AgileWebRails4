require 'test_helper'
require 'debugger'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Add two product to the cart" do
	cart= Cart.create
  	cart.add_product(products(:rails).id).save!
  	assert_equal 1, cart.line_items.length , "primer rails añadido"
  	cart.add_product(products(:rails).id).save!
  	assert_equal 1, cart.line_items.length , "segundo rails añadido"
  	cart.add_product(products(:ruby).id).save!
  	assert_equal 2, cart.line_items.length , "primer ruby añadido"

  end
end
