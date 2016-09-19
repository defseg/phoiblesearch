module PhonemesHelper
	def select_param(name, **options_hash)
		name = name.to_s.gsub("_"," ")
		if options_hash.empty?
			options_hash = {"any value" => nil,
		 					"true" => true,
		 					"false" => false}
		end
		"<p>#{name}: #{select_tag name, options_for_select(options_hash.to_a)}</p>".html_safe
	end
end
