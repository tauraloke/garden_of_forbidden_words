module Admin
  class ArticlesController < ApplicationController
    layout 'main'

    def new
      puts params
      @data = ""
      @bad_words_list = ""

      render :new
    end

    def create
      puts params
      check = BadWordsChecker::Wrapper.new(
        api: BadWordsChecker::Api.new(input_text: params[:data])
      ).check
      @data = check[:marked_text]
      @bad_words_list = check[:bad_words_list]
      render :new
    end
  end
end