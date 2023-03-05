# frozen_string_literal: true

require_relative 'tools'

class Quiz
  include Tools
  POINTS_FORMS = %w[балл балла баллов].freeze

  attr_reader :questions, :index

  def initialize(hashes)
    @questions = hashes.map { |hash| Question.new(hash) }
    @points_counter = 0
    @index = 0
  end

  def current_question
    @questions[@index]
  end

  def finish?
    @index > @questions.size - 1
  end

  def next_question
    @index += 1
  end

  def result
    "Вы набрали #{@points_counter} #{inclination(@points_counter, POINTS_FORMS)}"
  end

  def time_for_answer
    current_question.time_for_answer
  end

  def to_s
    "#{@index}. #{current_question}"
  end

  def user_answer_right?(user_answer)
    if current_question.right_answers.include?(current_question.variants[user_answer - 1])
      @points_counter += current_question.points
      'Верный ответ!'
    else
      "Неправильно. Правильный ответ: #{@questions[index - 1].right_answers.join(' || ')}"
    end
  end

  def variants
    current_question.variants.map.with_index(1) { |variant, i| "#{i}. #{variant}" }
  end
end
