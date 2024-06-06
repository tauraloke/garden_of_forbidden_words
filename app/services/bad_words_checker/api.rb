module BadWordsChecker
  class Api
    BAD_WORDS_AND_REACTS = {
      "картошк" => "ФУ, ГАДОСТЬ",
      "морков" => "ТОЖЕ ГАДОСТЬ",
    }

    attr :input_text
    attr :response
    attr :status

    def initialize(params)
      @input_text = params[:input_text] || ""
      @status = :new
    end

    def request
      answer = []
      BAD_WORDS_AND_REACTS.each do |key, value|
        answer.push "#{key} (#{value})" if @input_text.include? key
      end
      @status = :done
      @response = answer.join "\n"
    end
  end
end