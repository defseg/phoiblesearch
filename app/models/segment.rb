class Segment < ActiveRecord::Base
	belongs_to :phoneme, primary_key: :phoneme, foreign_key: :segment
	has_many :languages, through: :phoneme
end
