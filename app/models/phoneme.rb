class Phoneme < ActiveRecord::Base
	has_many :language_phonemes
	has_many :languages, -> { order(:language_code) }, through: :language_phonemes
	has_one :segment, primary_key: :phoneme, foreign_key: :segment

	def features
		Segment.where(segment: self.phoneme)
	end
end