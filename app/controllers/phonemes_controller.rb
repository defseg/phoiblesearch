class PhonemesController < ApplicationController
	def index
		@phonemes = Phoneme.all.order("phoneme")
	end

	def show
		@phoneme = Phoneme.find(params[:id]).includes(:languages)
	end

	def home
	end

	def search
		@segments = Segment.where(segment_params).includes(:phoneme).includes(:languages)
    @search = segment_params

    @languages = Hash.new { |h, k| h[k] = [] }
    @segments.each do |segment|
      segment.languages.each do |language|
        @languages[language] << segment
      end
    end
    @languages_keys = @languages.keys.sort_by { |l| l.language_code }
	end

	private

	def raw_search_params
		params.permit([:contains, :number, :number_or, :syllabic, :tone, 
			:stress, :short, :long, :consonantal, :sonorant, :continuant, 
			:approximant, :tap, :trill, :nasal, :lateral, :labial, :round, 
			:labiodental, :coronal, :anterior, :distributed, :dorsal, :high,
			:low, :front, :back, :tense, :retracted_tongue_root, 
			:advanced_tongue_root, :periodic_glottal_source, 
			:epilaryngeal_source, :spread_glottis, :constricted_glottis, 
			:fortis, :ejective, :implosive, :click])
	end

	def search_params
		raw_search_params.reject do |k, v|
			v.empty?
		end.map do |k, v|
      if v == "true"
        [k, "+"]
      elsif v == "false"
        [k, "-"]
      else
        [k, v]
      end
    end.to_h
	end

  def segment_params
    search_params.reject do |k, v|
      ["contains", "number", "number_or"].include?(k)
    end
  end
end
