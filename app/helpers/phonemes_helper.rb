module PhonemesHelper
	def select_param(name, **options_hash)
		if options_hash.empty?
			options_hash = {"Any #{name} value" => nil,
		 					"#{name}" => true,
		 					"non-#{name}" => false}
		end
		select_tag name, options_for_select(options_hash.to_a)
	end
end
