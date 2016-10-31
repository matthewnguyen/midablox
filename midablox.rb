class MidaBlox
	def initialize()
		@words = []
		@six_letter_words = []
		File.open("/usr/share/dict/words") do |file|
			file.each do |line|
				word = line.strip
				if word.length <= 6
					@words.push(word)
					if word.length == 6
						@six_letter_words.push(word)
					end
				end
			end
		end
	end

	def play
		setup
		while @attempts.length < 5
			handle_user_attempt
			puts "Your score: #{@score}"
			display_letters
		end
		game_end
	end
	
	def display_letters
		puts "Letters: #{@playing_letters.join.upcase}"
	end

	def setup
		puts "Start!"
		@score = 0
		@attempts = []
		@the_word = @six_letter_words.sample
		@playing_letters = @the_word.chars.shuffle
		puts "Welcome to MidaBlox!"
		display_letters
	end

	def handle_user_attempt
		attempt = gets.strip
		if validate_word(attempt)
			attempt_score = attempt.length
			@score += attempt_score
			puts "#{attempt_score} Points!!"
		end
	end

	def validate_word(attempt)
		if @attempts.include? attempt
			puts "You already used that word!"
			return false
		end
		@attempts.push(attempt)
		for letter in attempt.chars
			if not @playing_letters.include? letter
				puts "You used a bad letter!"
				return false
			end
		end
		if not @words.include? attempt
			puts "That's not a word!"
			return false
		end
		return true
	end

	def game_end
		puts "That's it! Here's your score: #{@score}"
		puts "The 6 letter word was #{@the_word.upcase}"
	end
end

my_game = MidaBlox.new
my_game.play

