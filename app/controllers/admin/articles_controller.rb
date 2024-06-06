module Admin
  class ArticlesController < ApplicationController
    layout 'main'

    def new
      puts params
      @data = ""
      render :new
    end

    def create
      puts params
      @data = params[:data].reverse
      render :new
    end
  end
end