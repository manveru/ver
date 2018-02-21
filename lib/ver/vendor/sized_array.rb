# The MIT Licence
#
# Copyright (c) 2004-2009 Pistos
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

class SizedArray < Array
  attr_reader :capacity

  def initialize(capacity = 10, *args)
    @capacity = capacity
    super(*args)
  end

  def resize
    slice!((0...-@capacity)) if size > @capacity
  end
  private :resize

  def concat(other_array)
    super(other_array)
    resize
    self
  end

  def fill(*args)
    retval = super(*args)
    resize
    self
  end

  def <<(item)
    retval = super(item)
    retval = shift if size > @capacity
    retval
  end

  def push(item)
    self << item
  end

  def unshift(item)
    retval = super(item)
    retval = pop if size > @capacity
    retval
  end
end
