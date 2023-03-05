# frozen_string_literal: true

require_relative 'lib/question'
require_relative 'lib/questions_parser'
require_relative 'lib/quiz'
require 'timeout'

path_to_files = File.join(__dir__, 'data', 'questions.xml')

quiz = Quiz.new(QuestionsParser.from_xml(path_to_files))

puts 'Мини-викторина. Ответьте на вопросы за отведенное количество времени.'

until quiz.finish?

  puts quiz.current_question

  user_answer =
    begin
      Timeout.timeout(quiz.time_for_answer) { $stdin.gets.to_i }
    rescue Timeout::Error
      puts 'Вы не уложились за отведенное время.'
      break
    end

  puts quiz.user_answer_right?(user_answer)
  quiz.next_question
end
puts quiz.result
