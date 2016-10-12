class PhonemesController < ApplicationController
	def index
		@phonemes = Phoneme.all.order("phoneme")
	end

	def show
		@phoneme = Phoneme.includes(:languages).includes(:segment).find(params[:id])
	end

	def home
	end
end
