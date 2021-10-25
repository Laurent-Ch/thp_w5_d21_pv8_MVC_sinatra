# require 'bundler'
# Bundler.require

class Gossip
  
  attr_accessor :author, :content

  def initialize(author_input, content_input)
    @author = author_input
    @content = content_input
  end

  def save   
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  # Source: https://stackoverflow.com/questions/12407035/ruby-csv-get-current-line-row-number
  def self.find(gossip_number)
    options = {:encoding => 'UTF-8', :skip_blanks => true}
    CSV.foreach("./db/gossip.csv", options).with_index do |row, i|
      if i == gossip_number.to_i
        return row
      end
    end
  end

  # Source : https://stackoverflow.com/questions/33321786/how-to-map-and-edit-a-csv-file-with-ruby
  def self.update(number, new_author, new_text)
    # Preparing the row number and the new content
    number_int = number.to_i
    edited_gossip = [new_author, new_text]
    # Put content of current csv file into temporary array
    puts rows_array = CSV.read("./db/gossip.csv")
    # Edit the targeted row
    rows_array.each.with_index do |row, index| 
      if index == number_int
        rows_array[index] = edited_gossip
      end
    end
    # Save the modifications
    CSV.open('./db/gossip.csv', 'wb') { |csv| rows_array.each{|row| csv << row}}
  end

end

# binding.pry
