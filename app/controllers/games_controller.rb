require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @answer = params[:answer]
    @letters = params[:grid].split
    if included?(@answer, @letters)
      if english_word?(@answer)
        @score = @answer.size
      else
        @score = 'not english'
      end
    else
      @score = 'not in the grid'
    end
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_dictionary = open(url).read
    word = JSON.parse(word_dictionary)
    word['found']
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end
end
