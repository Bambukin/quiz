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

  def finish?
    @index > @questions.size - 1
  end

  def next_question
    @index += 1
  end

  def question
    "#{@index + 1} -- #{@questions[@index].text} " \
       "(#{@questions[@index].points} #{inclination(@questions[@index].points, POINTS_FORMS)}) " \
       "Время на вопрос: #{@questions[@index].time_for_answer}сек.\n" \
      "#{variants.join("\n")}"
  end

  def result
    "Вы набрали #{@points_counter} #{inclination(@points_counter, POINTS_FORMS)}"
  end

  def time_for_answer
    @questions[@index].time_for_answer
  end

  def user_answer_right?(user_answer)
    if @questions[@index].right_answers.include?(@questions[@index].variants[user_answer - 1])
      @points_counter += @questions[@index].points
      'Верный ответ!'
    else
      "Неправильно. Правильный ответ: #{@questions[index - 1].right_answers.join(' || ')}"
    end
  end

  def variants
    @questions[@index].variants.map.with_index(1) { |variant, i| "#{i}. #{variant}" }
  end
end
