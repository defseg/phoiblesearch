class Language < ActiveRecord::Base
	has_many :languages_phonemes
	has_many :phonemes, through: :languages_phonemes
end