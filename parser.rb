#!/usr/bin/env ruby
# frozen_string_literal: true

## Call parse by providing file URL ./parser.rb ./webserver.log
require_relative './lib/log_visit'
web_log = LogVisit.new(ARGV[0])
web_log.parse_file

puts 'list of webpages with most page views'
web_log.sort_by('visits').map { |log| puts "#{log[0]} #{log[1]}" }

puts "\n\n"

puts 'list of webpages with most unique page'
web_log.sort_by('unique_visits').map { |log| puts "#{log[0]} #{log[1]}" }
