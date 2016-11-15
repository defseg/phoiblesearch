class PhonemesController < ApplicationController
	def index
		@phonemes = Phoneme.all.order("phoneme")
	end

	def show
		@phoneme = Phoneme.includes(:languages).includes(:segment).find(params[:id])
		@result_json = @phoneme.languages.map do |l| 
			{
				:language_name => "#{l.language_name} (#{l.source})",
			 	:latitude      => l.latitude,
			 	:longitude     => l.longitude
			} 
		end.to_json
	end

	def home
	end
end
