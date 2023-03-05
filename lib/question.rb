# frozen_string_literal: true

require_relative 'tools'
class Question
  include Tools
  attr_reader :text, :points, :right_answers, :variants, :time_for_answer

  POINTS_FORMS = %w[балл балла баллов].freeze

  def initialize(args)
    @text = args[:text]
    @variants = args[:variants].shuffle
    @right_answers = args[:right_answers]
    @points = args[:points].to_i
    @time_for_answer = args[:time_for_answer].to_i
  end

  def to_s
    <<~TEXT
      #{text} (#{points} #{inclination(points, POINTS_FORMS)})
      Время на вопрос: #{time_for_answer}сек.
      #{variants.join("\n")}
    TEXT
  end
end
