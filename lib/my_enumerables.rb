module Enumerable

  def my_each()
    for el in self
      yield el
    end
  end

  def my_each_with_index()
    i = 0
    for el in self
      yield el, i
      i += 1
    end
  end

  def my_select(&block)
  # self is a way of referencing the object we're calling the method on
  # &block is an explicit reference to the block which is called against the method
  # in this method the block is passing through a comparison against every element of a hash/array
    arr = []  
    hash = {}

    case self
    when Array
      self.my_each {|el| arr.push(el) if block.call(el) }
      return arr
    when Hash
      self.my_each {|el| hash.push(el) if block.call(el) }
      return hash
    end

  end

  def my_all?(&block)
    arr = []  
    hash = {}

    case self
    when Array
      self.my_each {|el| arr.push(el) if block.call(el) }
      if arr.length == self.length 
        return true
      else
        return false
      end

    when Hash
      self.my_each {|el| hash.push(el) if block.call(el) }
      if hash.length == self.length 
        return true
      else
        return false
      end

    end
  end

  def my_any?(&block)
    
    self.my_each {|el| 
      if block.call(el)
        return true 
      end
    }

    return false
    # returns false if no variable is matched during iteration
  end

  def my_none?(&block)

    self.my_each {|el| 
      if block.call(el)
        return false 
      end
    }

    return true
  end

  def my_count(&block)
    i = 0

    self.my_each {|el|
      if block_given? 
        if block.call(el)
          i += 1
        end
      else 
        return self.count
      end
    }

    return i
  end

  def my_map(&block)
    arr = []
    hash = []

    case self
    when Array
      self.my_each {|el|
        arr.push(block.call(el))}
      return arr
    when Hash
      self.my_each {|el|
        hash.push(block.call(el))}
      return hash
    end
  end

  def my_inject(number, &block)

    self.my_each {|el| number = block.call(number, el)}

    return number
  end
end
