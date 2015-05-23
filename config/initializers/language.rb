stop_words_file = "#{Rails.root}/config/language/stop_words.json"

json = File.new(stop_words_file, 'r')
STOP_WORDS = Oj.load(json)
