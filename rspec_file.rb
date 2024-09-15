require 'colorize'

puts "Enter you the file you would like to Rspec".colorize(:grey)

@file = gets.strip

def check_directory
	`cd #{@file} && ls .` 
	#puts File.extname('./deck/deck_runner.rb')
end

check_directory
#assignment = condition ? if : else

