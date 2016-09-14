class LanguagesController < ApplicationController
	def index
		@language_count = Language.count
		@languages = Language.all.order("language_code ASC")
	end

	def show
		@language   = Language.find(params[:id])
		@consonants = @language.phonemes.where(klass: "consonant")
		@vowels     = @language.phonemes.where(klass: "vowel")
		@tones      = @language.phonemes.where(klass: "tone")
	end

	def by_code
		@languages = Language.where(language_code: params[:language_code])
		@code = params[:language_code]
	end
end
