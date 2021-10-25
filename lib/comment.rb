#  require 'bundler'
#  Bundler.require

class Comment
  
  attr_accessor :gossip_number, :author, :content

  def initialize(gossip_number, author, content)
    @gossip_number = gossip_number
    @author = author
    @content = content
  end

  def save   
    CSV.open("./db/comment.csv", "ab") do |csv|
      csv << [@gossip_number, @author, @content]
    end
  end

  def self.all(gossip_number)
    all_comments = []
    CSV.read("./db/comment.csv").each do |csv_line|
      if csv_line[0].to_i == gossip_number.to_i
      puts all_comments << Comment.new(csv_line[0], csv_line[1], csv_line[2])
      end
    end
    return all_comments
  end

end

# binding.pry
