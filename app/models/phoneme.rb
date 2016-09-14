class Phoneme < ActiveRecord::Base
	has_many :language_phonemes
	has_many :languages, -> { order(:language_code) }, through: :language_phonemes
end