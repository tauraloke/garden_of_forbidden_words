module BadWordsChecker
  class Api < ApplicationService
    BAD_WORDS_AND_REACTS = {
      "картошк" => "ФУ, ГАДОСТЬ",
      "морков" => "ТОЖЕ ГАДОСТЬ",
    }

    attr :input_text
    attr :response
    attr :status

    def initialize(input_text:)
      @input_text = input_text || ""
      @status = :new
    end

    def call
      request
    end

    private

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