class Product < ActiveRecord::Base
	has_many :line_items
	before_destroy :ensure_not_referenced_by_any_line_item

	validates :title, :description, :image_url, presence:true
	validates :title, uniqueness: true
	validates :title, length: {minimum: 10}
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :image_url, allow_blank:true, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'must be a URL for GIF, JPG or PNG image.'
	}

	#Este metodo lo usa el sistema de cache en la vista para
	# ver si ha habido cambio en la base de datos
	def self.latest
		Product.order(:updated_at).last
	end

	# este metodo se asegura que no hay lineas de
	# algun carrito que referencien este producto
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'Está presente en lineas de carritos')
			return false
		end
	end
end
