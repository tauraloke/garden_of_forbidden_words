module BadWordsChecker
  class Wrapper < ApplicationService
    def initialize(api)
      @api ||= api
      raise "Empty api object" if @api.nil?
    end

    def call
      @api.call
      check
    end

    private

    def check
      {
        bad_words_list: @api.response.split("\n"),
        marked_text: parse(@api.input_text, @api.response)
      }
    end

    def parse(text, list)
      bad_word_rows = list.split("\n")
      bad_word_matches = []
      bad_word_rows.each do |row|
        matches = /([^\(]+) \(([^\)]+)\)/.match(row)
        if matches
          text.gsub! /([^\s]*?)#{matches[1]}(\p{L}*?)[^\p{L}]/, '\1' + matches[1] + '\2' + ' (' + matches[2] + ') '
        end
      end

      text
    end
  end
end