# генератор примеров для игры
# создает примеры с методами правильного ответа и строчного вывода
class Question
  OPERATORS = ['+','-','*','/'].freeze

  def self.generate_question
    operator = OPERATORS.sample

   # пенерируем переменные относительно оператора
   # чтобы удовлетворять условию задачи:
   # Числа в примерах, в том числе и результат - одно-/двух-значные, целочисленные, положительные.
    case operator
    when '+'
      x = rand(1..50)
      y = rand(1..49)
    when '-'
      x = rand(1..99)
      y = (1..(x - 1)).to_a.sample
    when '*'
      x = rand(1..10)
      y = rand(1..9)
    else
      x = rand(1..99)
      del = []
      x.downto(1) { |i| del << i if x % i == 0 }
      y = del.sample
    end

    new(x, y, operator)
  end

  def initialize(x, y, operator)
    @x = x
    @y = y
    @operator = operator
  end

  def answer
    @x.method(@operator).(@y)
  end

  def to_s
    "#{@x} " + @operator + " #{@y} = ?"
  end
end
