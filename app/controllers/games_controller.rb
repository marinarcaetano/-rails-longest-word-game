require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    # check if all the letters is in @letters
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    word_letters = params[:word].split('')
    word_letters.each do |letter|
      if !@letters.include?(letter)
        @answer = "Sorry, but #{params[:word]} can not be built out of #{@letters}"
      elsif user['found'] == false
        @answer = "Sorry but #{params[:word]} does not seem to be a valid English word... "
      else
        @answer = "Congratulations. #{params[:word]} is a valid English word!"
      end
    end
  end
end
