# Print a table to the terminal with the count, date of earliest violation, and date of latest violation for each violation type.
require 'csv'
require 'time'

class Violation
  def initialize
    @table = {}
  end

  def merge_violations
    CSV.foreach './data/violations.csv', headers: true, header_converters: :symbol do |row|
      type = row[:violation_type]
      date = Time.parse(row[:violation_date])
      @table[type] = {} unless @table[type]
      @table[type][:count] = 0 unless @table[type][:count]
      @table[type][:earliest_violation] = date unless @table[type][:earliest_violation]
      @table[type][:latest_violation] = date unless @table[type][:latest_violation]
      @table[type][:count] += 1
      @table[type][:earliest_violation] = date if date > @table[type][:earliest_violation]
      @table[type][:latest_violation] = date if date > @table[type][:latest_violation]
    end
    puts @table
  end
end
