require "../src/intervalestimation"
require "option_parser"

begin
	OptionParser.parse! do |parser|
		parser.banner = "Usage: main file_name:string l:int boundary:double"
		parser.on("-v", "--version", "Show version") { puts Intervalestimation::VERSION; exit 0 }
		parser.on("-h", "--help", "Show this help") { puts parser; exit 0 }
	end

	if ARGV.size >= 1
    boundary = (ARGV.size >= 3) ? ARGV[2].to_f : 0.5
		array = [] of Float64
		File.read_lines(ARGV[0]).each do |line|
			array << line.chomp.to_f - boundary
		end
		l = 200
	else
		array = [0.1,0.1,0.2,-0.5,0.1,0.1,0.2,-0.2,-0.3,0.2,0.1,0.1,-0.2]
		l = 2
	end
	l = ARGV[1].to_i if ARGV.size >= 2

	int = Intervalestimation::Sequence.new(array, l)
  int.show

rescue e
	STDERR.puts e
	exit 1
end
