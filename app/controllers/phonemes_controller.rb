class PhonemesController < ApplicationController
	def index
		@phonemes = Phoneme.all.order("phoneme")
	end

	def show
		@phoneme = Phoneme.find(params[:id])
	end
end
