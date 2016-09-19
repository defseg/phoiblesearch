class PhonemesController < ApplicationController
	def index
		@phonemes = Phoneme.all.order("phoneme")
	end

	def show
		@phoneme = Phoneme.includes(:languages).find(params[:id])
	end

	def home
	end

	def search
    if params[:contains].empty?
      @contains = true
      query = contains_query
    else
      @contains = false
      query = does_not_contain_query
    end

    search = ActiveRecord::Base.connection.execute(query)

    @result = Hash.new { |h, k| h[k] = [] }
    curr_lang = nil
    search.each do |item|
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
    if number_params.all? { |k, v| v.empty? }
      return ""
    else 
      return "HAVING count(*) #{params[:number_or].empty? ? '=' : params[:number_or]} #{params[:number]}"
    end
  end

  def contains_query
    <<-SQL
      SELECT 
        phonemes.id AS phoneme_id, phonemes.phoneme, a.* 
      FROM 
        phonemes
        JOIN language_phonemes ON phonemes.id = language_phonemes.phoneme_id 
        JOIN languages ON language_phonemes.language_id = languages.id 
        JOIN segments ON phonemes.phoneme = segments.segment, 
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
  end

  def does_not_contain_query
    <<-SQL
      SELECT 
        l1.id AS language_id, l1.*
      FROM
        languages AS l1
      WHERE 
        NOT EXISTS (
          SELECT 
            l2.* 
          FROM 
            languages AS l2
            JOIN language_phonemes ON l2.id = language_phonemes.language_id 
            JOIN phonemes ON phonemes.id = language_phonemes.phoneme_id 
            JOIN segments ON phonemes.phoneme = segments.segment 
          WHERE 
            #{segment_conditions} AND
            l1.id = l2.id
          GROUP BY 
            l2.id 
          #{number_conditions}
        )
      ;
    SQL
  end
end
