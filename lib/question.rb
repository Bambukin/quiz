# frozen_string_literal: true

class Question
  attr_reader :text, :points, :right_answers, :variants, :time_for_answer

  def initialize(args)
    @text = args[:text]
    @variants = args[:variants].shuffle
    @right_answers = args[:right_answers]
    @points = args[:points].to_i
    @time_for_answer = args[:time_for_answer].to_i
  end
end
