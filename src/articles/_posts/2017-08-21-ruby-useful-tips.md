---
layout: post
title: Useful tips, little algorithms for Ruby apps, inspired by coding challenges
excerpt: Useful tips, little algorithms for Ruby applications in different situations, inspired by coding challenges
date: 2017-08-21 19:00:12 +03:00 
name: 2017-08-21-ruby-useful-tips
tags: ruby algorithms
type: post
author: Victor

published: false
footer_related_posts: false

comments: true
---

### Useful tips

#### Print  formatted output 

```ruby
amount = 3.001  
'$%.2f' % amount  # -> 3.00
```

#### Flatten and compact Array

```
# flatten

s = [1, 2, 3]           #=> [1, 2, 3]
t = [4, 5, 6, [7, 8]]   #=> [4, 5, 6, [7, 8]]
a = [s, t, 9, 10]       #=> [[1, 2, 3], [4, 5, 6, [7, 8]], 9, 10]
a.flatten                 #=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
a = [1, 2, [3, [4, 5]]]
a.flatten(1)              #=> [1, 2, 3, [4, 5]]

# compact
# Returns a copy of self with all nil elements removed.
["a", nil, "b", nil, "c", nil].compact #=> ["a", "b", "c"]
```

#### Count symbols in string variable from the list 

```ruby
inputStr = "Hello world"
# 3 versions:
inputStr.count("aeiou") # -> 3
 inputStr.downcase.count("aeiou")  # -> 3
inputStr.scan(/[aeiou]/i).size # -> 3
``` 
 
#### The latest and the longest word in string 

```ruby
string_of_words = "The latest and the longest word in string"
# 2 versions:
string_of_words.split.sort_by(&:size).last # -> longest
string_of_words.split(" ").sort_by(&:length).pop # -> longest
```
 
#### Reverse digits in the number

```ruby
number = 3001  
number.to_s.chars.reverse.join.to_i # -> 1003
```
 
#### Inverse numbers at the array

```ruby
list = [1, -1, 3, -5] 
# 2 versions:
list.collect { |n| n * -1 } # ->  [-1, 1, -3, 5] 
list.map(&:-@) # ->  [-1, 1, -3, 5] 
```
 
#### Convert number to binary and count the 1, even or odd.

```ruby
number = 9910
# 2 versions:
number.to_s(2).count("1").even? ? "Even" : "Odd" # -> Even  
"#{['Even','Odd'][number.to_s(2).count('1')&1]}" # -> Even 
``` 

#### Replace the last Bang symbol in string

```ruby
str = "!!Hello!!!"
# 2 versions:
str.gsub(/\!$/, '') # -> !!Hello!!
str.chomp('!') # -> !!Hello!! 
# If you need to replace all Bang symbols at the end of string
str.gsub(/\!+$/, '') # -> !!Hello
# If you need to replace all Bang symbols at the start of string
str.gsub(/^\!+/, '') # -> Hello!!!
```

#### Get all permutations for word

```ruby
word = "abba"
word.chars.to_a.permutation.map(&:join).uniq # -> ["abba", "abab", "aabb", "baba", "baab", "bbaa"]
``` 


### Metaprogramming


#### How to Call Private Methods On Objects

```ruby
obj.send(:method [, args...])
obj.class_exec { method }
obj.class_eval { method }
```

#### Evaluate code in blocks

Evaluate code for Object instance
```ruby
[1, 2, 3, 4].instance_eval('size') # -> 4
[1, 2, 3, 4].instance_eval { inject(:&+) / size.to_f } # -> 2.5   arithmetical mean
```

Evaluate code for Module, it could be useful for dynamical methods generation
```ruby
class Fixnum
  def self.create_multiplier(name, num)
    module_eval "def #{name}; self * #{num}; end"
  end
end

Fixnum.create_multiplier('multiply_by_pi', Math::PI)
4.multiply_by_pi # -> 12.5663706143592
```

#### Include vs Extend

As you can see below, include makes the foo method available to an instance of a 
class and extend makes the foo method available to the class itself.
http://www.railstips.org/blog/archives/2009/05/15/include-vs-extend-in-ruby/

```ruby
module Foo
  def foo
    puts 'heyyyyoooo!'
  end
end

class Bar
  include Foo
end

Bar.new.foo # heyyyyoooo!
Bar.foo # NoMethodError: undefined method ‘foo’ for Bar:Class

class Baz
  extend Foo
end

Baz.foo # heyyyyoooo!
Baz.new.foo # NoMethodError: undefined method ‘foo’ for #<Baz:0x1e708>
```



