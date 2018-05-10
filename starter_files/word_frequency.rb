class Wordfreq
  STOP_WORDS = ['a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from',
    'has', 'he', 'i', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 'to',
    'were', 'will', 'with']

FILENAME = "Now, therefore I, Abraham Lincoln, President of the United States, by virtue of the power in me vested as Commander-in-Chief, of the Army and Navy of the United States in time of actual armed rebellion against the authority and government of the United States, and as a fit and necessary war measure for suppressing said rebellion, do, on this first day of January."

  def initialize(filename)
    @filename = filename
  end

  def frequency(word)
    file = File.read @filename
    file_downcase = file.downcase
    file_sub = file_downcase.gsub(/[^a-z\s]/, ' ')
    file_array = file_sub.split(" ")
    removed_stop_words = file_array.delete_if do |element|
      STOP_WORDS.include?(element)
    end
    removed_stop_words.count(word)
  end

  def frequencies
    file = File.read @filename
    file_downcase = file.downcase
    file_sub = file_downcase.gsub(/[^a-z\s]/, ' ')
    file_array = file_sub.split(" ")
    removed_stop_words = file_array.delete_if do |element|
      STOP_WORDS.include?(element)
    end
    words_count = Hash.new 0
    removed_stop_words.each do |word|
      words_count[word] += 1
    end
    words_count
  end

  def top_words(number)
    word_count_hash = frequencies
    sorted_array = word_count_hash.sort_by do |key, value| 
      [-value, key]
    end
    sorted_array.take(number)
  end

  def print_report
    word_count_hash = frequencies
    sorted_array = word_count_hash.sort_by do |key, value| 
      [-value, key]
    end
    sorted_hash = sorted_array.take(10).to_h
    sorted_hash.each do |key, value|
     puts " #{key} | #{value.times { print "*"}}"
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exists?(full_filename)
      wf = Wordfreq.new(full_filename)
      wf.print_report
    else
      puts "#{filename} does not exist!"
    end
  else
    puts "Please give a filename as an argument."
  end
end
