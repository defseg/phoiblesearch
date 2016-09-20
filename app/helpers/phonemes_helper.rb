module PhonemesHelper
	def select_param(name, *options_arr)
		display_name = name.to_s.gsub("_"," ")
		options_arr = ["+", "-"] if options_arr.empty?
		options_arr = options_arr.zip(options_arr).unshift(["Any value", nil])
		"<p>#{display_name}: #{select_tag name, options_for_select(options_arr)}</p>".html_safe
	end
end
