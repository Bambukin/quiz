# frozen_string_literal: true

class Question
  attr_reader :text, :points, :right_answers, :variants, :time_for_answer

  def initialize(params)
    @text = params[:text]
    @variants = params[:variants].shuffle
    @right_answers = params[:right_answers]
    @points = params[:points].to_i
    @time_for_answer = params[:time_for_answer].to_i
  end
end
