# frozen_string_literal: true
# QuestionsParser.from_xml(path) - возвращает хеши для Question.new(elem)

require_relative 'questions_parser'
require_relative 'tools'

class Quiz
  include QuestionsParser
  include Tools
  POINTS_FORMS = %w[балл балла баллов].freeze

  attr_reader :questions

  def initialize
    @questions = nil
    @points_counter = 0
  end

  def read_from_xml(path)
    @questions = from_xml(path).map { |hash| Question.new(hash) }
  end

  def question(index)
    "#{index + 1} -- #{@questions[index].text} " \
       "(#{@questions[index].points} #{inclination(@questions[index].points, POINTS_FORMS)}) " \
       "Время на вопрос: #{@questions[index].time_for_answer}сек.\n" \
      "#{variants(index).join("\n")}"
  end

  def variants(index)
    @questions[index].variants.map.with_index(1) { |variant, i| "#{i}. #{variant}" }
  end

  def user_answer_right?(user_answer, index)
    if @questions[index].right_answers.include?(@questions[index].variants[user_answer - 1])
      @points_counter += @questions[index].points
      'Верный ответ!'
    else
      "Неправильно. Правильный ответ: #{@questions[index].right_answers.join(' || ')}"
    end
  end

  def result
    "Вы набрали #{@points_counter} #{inclination(@points_counter, POINTS_FORMS)}"
  end

  def finish?(index)
    index > @questions.size - 1
  end
end
