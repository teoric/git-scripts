#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

authors = Hash.new(0)

ARGF.each do |line|
  line = line.force_encoding("cp1252").encode("utf-8")
  if line.match(/(?<=author:\s)\S+(?=;)/)
    # puts $&
    authors[$&] += 1
  end
end

# authors.each {|k,v|
#   puts "#{k} = NAME <#{k}@ikp.uni-bonn.de>"
# }

authors.each {|k,v|
  puts "#{k}: #{v}"
}
