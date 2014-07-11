#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# use as:
# $ svn log | authors.rb > authors-transform.txt
#
# generates a template for an authors-transform.txt to be used for rewriting
# the commit history with nice names.

authors = Hash.new(0)

ARGF.each do |line|
  line = line.force_encoding("cp1252").encode("utf-8") # old repository
  if line.match(/(?<=author:\s)\S+(?=;)/)
    # puts $&
    authors[$&] += 1
  end
end

authors.each {|k,v|
  puts "#{k} = NAME <#{k}@SERVER>"
}

# Count authors instead:
# authors.each {|k,v|
#   puts "#{k}: #{v}"
# }
