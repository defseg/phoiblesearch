class Language < ActiveRecord::Base
	has_many :language_phonemes
	has_many :phonemes, through: :language_phonemes

	def name_and_source
		"#{self.language_name} (#{self.source})"
	end
end