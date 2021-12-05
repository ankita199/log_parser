# frozen_string_literal: true

require_relative './log'

# LogVisit Class
class LogVisit
  attr_reader :file_path, :logs

  def initialize(file_path)
    @file_path = file_path
    @logs = []
  end

  def parse_file
    return 'File does not exists' unless File.exist?(file_path)

    File.open(@file_path).each_line do |line|
      url, ip = line.split
      logs << Log.new(url, ip)
    end
    @logs = logs.group_by(&:url)
  end

  def sort_by(condition)
    return [] unless %w[visits unique_visits].include?(condition)

    case condition
    when 'visits'
      @logs.map { |url, visits| [url, visits.count] }
    when 'unique_visits'
      @logs.map { |url, visits| [url, visits.map(&:ip).uniq.count] }
    end.sort { |a, b| b.last <=> a.last }
  end
end
