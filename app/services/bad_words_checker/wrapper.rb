module BadWordsChecker
  class Wrapper
    def initialize(params)
      @api ||= params[:api]
      raise "Empty api object" if @api.nil?
    end

    def check
      @api.request

      {
        bad_words_list: @api.response.split("\n"),
        marked_text: parse(@api.input_text, @api.response)
      }
    end

    private

    def parse(text, list)
      bad_word_rows = list.split("\n")
      bad_word_matches = []
      bad_word_rows.each do |row|
        matches = /([^\(]+) \(([^\)]+)\)/.match(row)
        puts matches
        text.gsub! /([^\s]*)#{matches[1]}([^\s]*)/, '\1' + matches[1] + ' (' + matches[2] + ')' + '\2' if matches
      end

      text
    end
  end
end