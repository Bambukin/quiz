# frozen_string_literal: true

require_relative 'lib/question'
require_relative 'lib/tools'
require_relative 'lib/quiz'
require 'timeout'

path_to_files = File.join(__dir__, 'data', 'questions.xml')

quiz = Quiz.new
quiz.read_from_xml(path_to_files)

puts 'Мини-викторина. Ответьте на вопросы за отведенное количество времени.'

index = 0
until quiz.finish?(index) do
  # задать вопрос c вариантами ответа
  puts quiz.question(index)

  # получить ответ
  user_answer = nil
  begin
    Timeout.timeout(quiz.questions[index].time_for_answer) { user_answer = $stdin.gets.to_i }
  rescue Timeout::Error
    puts 'Вы не уложились за отведенное время.'
    break
  end

  puts quiz.user_answer_right?(user_answer, index)
  index += 1
end
puts quiz.result
