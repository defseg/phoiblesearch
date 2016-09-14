class Phoneme < ActiveRecord::Base
	has_many :languages_phonemes
	has_many :languages, through: :languages_phonemes
end