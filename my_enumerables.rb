module Enumerable
  def my_each_with_index
    index = 0
    self.my_each do |value|
      yield value, index
      index += 1
    end
    self
  end

  def my_select
    selected = []
    self.my_each do |value|
      selected << value if yield(value)
    end
    selected
  end

  def my_all?
    selected = []
    self.my_each do |value|
      return false unless yield(value)
    end
    true
  end

  def my_any?
    self.my_each do |value|
      return true if yield(value)
    end
    false
  end

  def my_none?
    self.my_each do |value|
      return false if yield(value)
    end
    true
  end

  def my_count
    if block_given?
      count = 0
      self.my_each { |value| count += 1 if yield(value) }
      count
    else
      self.size
    end
  end

  def my_map
    self.my_each_with_index do |value, index|
      self[index] = yield value
    end
    self
  end

  def my_inject(initial = nil, sym = nil)
    accumulator = initial
    if block_given?
      self.my_each { |item| accumulator = yield(accumulator, item) }
    elsif sym
      self.my_each { |item| accumulator = accumulator.public_send(sym, item) }
    end
    accumulator
  end
end

class Array
  def my_each
    for value in self
      yield value
    end
    self
  end
end

nums = [1, 4, 5, 8]
p nums.my_inject(0) { |result, value| result + value }
