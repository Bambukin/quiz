# frozen_string_literal: true

# Данный модуль позволяет изменять окончания в зависимости от количества объектов
# На вход принимает количество объектов и массив из 3х форм.
# Напрмиер w%[программист, программиста, программистов]
module Tools
  def self.inclination(amount, words)
    return words[2] if (amount % 10).zero? || (amount % 10) > 4 || (amount % 100).between?(11, 14) # программистов
    return words[1] if (amount % 10).between?(2, 4) # программиста

    words[0] # программист
  end
end
