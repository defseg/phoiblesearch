class Phoneme < ActiveRecord::Base
	has_many :language_phonemes
	has_many :languages, through: :language_phonemes
end