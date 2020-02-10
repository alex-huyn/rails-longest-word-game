require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def word_ok?(attempt, grid)
    result = true
    attempt.upcase.split('').each do |letter|
      if !grid.include?(letter)
        result = false
        return result
      else
        grid.delete_at(grid.index(letter))
      end
    end
    return result
  end

  def score
    @attempt = params[:answer].upcase
    @letters = params[:letters].split(' ')
    @result = ''
    word_string = open("https://wagon-dictionary.herokuapp.com/#{@attempt}").read
    word_hash = JSON.parse(word_string)
    if word_hash['found'] == false
      @result = "Sorry but #{@attempt} is not an english word"
    elsif !word_ok?(@attempt, @letters)
      @result = "Sorry but #{@attempt} is not in the grid"
    else
      @result = 'Well done'
    end
  end
end
