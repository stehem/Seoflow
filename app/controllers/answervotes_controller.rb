class AnswervotesController < ApplicationController
respond_to :js

def create
@answervote = Answervote.find_by_answer_id(params[:answer_id])
  if params[:pos] == "true"
    @answervote.update_attribute(:votesnb , @answervote.votesnb + 1)
    Reputation.vote_up_answer(params[:answer_id])
  elsif params[:neg] == "true"
    @answervote.update_attribute(:votesnb , @answervote.votesnb - 1)
    Reputation.vote_down_answer(params[:answer_id])
  end
end

end
