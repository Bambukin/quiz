# frozen_string_literal: true

require_relative 'lib/question'
require_relative 'lib/questions_collection'
require_relative 'lib/tools'
require 'timeout'

path_to_files = File.join(__dir__, 'data', 'questions.xml')

quiz = QuestionsCollection.from_xml(path_to_files)

questions = quiz.collection

puts 'Мини-викторина. Ответьте на вопросы за отведенное количество времени.'
points_counter = 0
points_forms = %w[балл балла баллов]

questions.each.with_index(1) do |question, id|
  puts "#{id} -- #{question.text} " \
       "(#{question.points} #{Tools.inclination(question.points, points_forms)}) " \
       "Время на вопрос: #{question.time_for_answer}сек."

  question.variants.each.with_index(1) { |variant, i| puts "#{i}. #{variant}" }

  user_answer = nil
  begin
    Timeout.timeout(question.time_for_answer) { user_answer = $stdin.gets.to_i }
  rescue Timeout::Error
    puts 'Вы не уложились за отведенное время, ' \
          "но успели набрать: #{points_counter} #{Tools.inclination(points_counter, points_forms)}"
    exit
  end

  if question.right_answers.include?(question.variants[user_answer - 1])
    puts 'Верный ответ!'
    points_counter += question.points
  else
    puts "Неправильно. Правильный ответ: #{question.right_answers.join(' || ')}"
  end
end

puts "Вы набрали #{points_counter} #{Tools.inclination(points_counter, points_forms)}"
