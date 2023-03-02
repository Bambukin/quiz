# frozen_string_literal: true

require 'rexml/document'

class QuestionsParser
  def self.from_xml(path)
    file = File.new(path)
    doc = REXML::Document.new(file)
    file.close
    doc.get_elements('questions/question').map do |question|
      seconds = question.attributes['seconds']
      points = question.attributes['points']
      text = question.elements[1].text

      variants = question.get_elements('variants/variant').map(&:text)
      right_answers = question.get_elements("variants/variant[@right='true']").map(&:text)

      { text: text,
        variants: variants,
        right_answers: right_answers,
        points: points,
        time_for_answer: seconds }
    end
  end
end
