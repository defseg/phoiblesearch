class LanguagePhoneme < ActiveRecord::Base
	belongs_to :language
	belongs_to :phoneme
end