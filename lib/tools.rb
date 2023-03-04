# frozen_string_literal: true

# Данный модуль позволяет изменять окончания в зависимости от количества объектов
# На вход принимает количество объектов и массив из 3х форм.
# Напрмиер w%[программист, программиста, программистов]
module Tools
  def inclination(amount, words)
    return words[2] if (amount % 100).between?(11, 14) # программистов

    case amount % 10
    when 1 then words[0] # программист
    when 2..4 then words[1] # программиста
    else words[2] # программистов
    end
  end
end
