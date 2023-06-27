# frozen_string_literal: true

require 'rexml/document'

class QuestionsParser
  def self.from_xml(path)
    doc = REXML::Document.new(File.read(path))
    doc.get_elements('questions/question').map do |question|
      seconds = question.attributes['seconds']
      points = question.attributes['points']
      text = question.get_elements('text').first.text

      variants = question.get_elements('variants/variant').map(&:text)
      right_answers = question.get_elements("variants/variant[@right='true']").map(&:text)

      {
        text: text,
        variants: variants,
        right_answers: right_answers,
        points: points,
        time_for_answer: seconds
      }
    end
  end
end
