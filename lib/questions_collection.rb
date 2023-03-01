# frozen_string_literal: true

require 'rexml/document'

class QuestionsCollection
  def self.from_xml(args)
    collection = []

    file = File.new(args)
    doc = REXML::Document.new(file)
    file.close
    doc.elements.each('questions/question') do |question|
      seconds = question.attributes['seconds']
      points = question.attributes['points']
      text = question.elements[1].text

      variants = []
      right_answers = []

      question.elements.each('variants/variant') { |variant| variants << variant.text }
      question.elements.each("variants/variant[@right='true']") { |variant| right_answers << variant.text }

      collection << Question.new(text: text,
                                 variants: variants,
                                 right_answers: right_answers,
                                 points: points,
                                 time_for_answer: seconds)
    end

    new(collection)
  end

  attr_accessor :collection

  def initialize(collection = [])
    @collection = collection
  end
end
