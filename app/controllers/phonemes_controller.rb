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
    query = <<-SQL
      SELECT 
        p.id AS phoneme_id, p.phoneme, a.* 
      FROM 
        phonemes AS p
        JOIN language_phonemes ON p.id = language_phonemes.phoneme_id 
        JOIN languages ON language_phonemes.language_id = languages.id 
        JOIN segments ON p.phoneme = segments.segment, 
        (
          SELECT 
            languages.id AS language_id, languages.language_name, languages.language_code, languages.source
          FROM 
            languages
            JOIN language_phonemes ON languages.id = language_phonemes.language_id 
            JOIN phonemes ON phonemes.id = language_phonemes.phoneme_id 
            JOIN segments ON phonemes.phoneme = segments.segment
          WHERE 
            #{segment_conditions}
          GROUP BY
            languages.id
            #{number_conditions}
        ) a 
      WHERE 
        a.language_id = language_phonemes.language_id AND 
        #{segment_conditions}
      ;
    SQL

    search = ActiveRecord::Base.connection.execute(query)

    @result = Hash.new { |h, k| h[k] = [] }
    curr_lang = nil
    search.each do |item|
      p item
      lang_hash = item.slice("language_id", "language_name", "language_code", "source")
      curr_lang = lang_hash if lang_hash != curr_lang
      @result[curr_lang] << item.slice("phoneme_id", "phoneme")
    end
	end

	private

  def segment_conditions
    segment_params = params.permit([:syllabic, :tone, 
      :stress, :short, :long, :consonantal, :sonorant, :continuant, 
      :approximant, :tap, :trill, :nasal, :lateral, :labial, :round, 
      :labiodental, :coronal, :anterior, :distributed, :dorsal, :high,
      :low, :front, :back, :tense, :retracted_tongue_root, 
      :advanced_tongue_root, :periodic_glottal_source, 
      :epilaryngeal_source, :spread_glottis, :constricted_glottis, 
      :fortis, :ejective, :implosive, :click]).reject do |k, v|
      v.empty? || ["contains", "number", "number_or"].include?(k)
    end

    segment_conditions_arr = []
    segment_params.each do |k, v|
      if v == "true"
        segment_conditions_arr << "segments.#{k} = '+'"
      elsif v == "false"
        segment_conditions_arr << "segments.#{k} = '-'"
      end
    end
    segment_conditions_arr.join(" AND ")
  end

  def number_conditions
    number_params = params.permit([:contains, :number, :number_or])
    # :contains  - nil = contains, 'donotcontain'
    # :number    - nil = any, 1..10 = 1..10
    # :number_or - nil = number of, or less = '<=', or more = '>='
    if number_params.all? { |k, v| v.empty? }
      return ""
    elsif number_params[:contains].empty? 
      return "HAVING count(*) #{params[:number_or].empty? ? '=' : params[:number_or]} #{params[:number]}"
    elsif number_params[:contains]
      throw "this isn't done yet"
    end
  end
end
