module BrandHelper
	def brand_select
		@brands = Brand.all

		render(partial: 'shared/brand')
	end
end
