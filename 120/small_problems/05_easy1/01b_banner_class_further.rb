# Modify this class so new will optionally let you specify a fixed banner width
# at the time the Banner object is created. The message in the banner should be
# centered within the banner of that width. Decide for yourself how you want to
# handle widths that are either too narrow or too wide.
#
# class Banner
#   def initialize(message)
#     @message = message
#   end
#
#   def to_s
#     [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
#   end
#
#   private
#
#   def horizontal_rule
#     "+-#{'-' * @message.size}-+"
#   end
#
#   def empty_line
#     "| #{' ' * @message.size} |"
#   end
#
#   def message_line
#     "| #{@message} |"
#   end
# end

class Banner
  def initialize(message, width = 60)
    @message = message
    @width = width
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+-#{'-' * @width}-+"
  end

  def empty_line
    "| #{' ' * @width} |"
  end

  def message_line
    make_parts.map do |part|
      "| #{part.center(@width)} |"
    end
  end

  def make_parts
    parts = []
    save = []
    @message.split.each do |word|
      if (word.size + save.join(' ').size) <= (@width - 2)
        save << word
      else
        parts << save.join(' ')
        save = [word]
      end
    end
    parts << save.join(' ')
  end
end

=begin
break up the message in to width - 2 parts
but you can only break on words:
loop through words
  if word size + saved word join with space size <= part
    add word to save
  else move save join with space to parts
    init save
    move word to save
  end
  for each part make a message line
=end

banner = Banner.new('Hello world!', 40)
puts banner
# +--------------------------------------+
# |                                      |
# |             Hello world!             |
# |                                      |
# +--------------------------------------+

banner = Banner.new('To boldly go where no one has gone before.', 20)
puts banner
# +------------------+
# |                  |
# |   To boldly go   |
# | where no one has |
# |   gone before.   |
# |                  |
# +------------------+

banner = Banner.new('')
puts banner
# +------------------------------------------------------------------------------+
# |                                                                              |
# |                                                                              |
# |                                                                              |
# +------------------------------------------------------------------------------+
