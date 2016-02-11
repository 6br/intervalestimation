require "./intervalestimation/*"

module Intervalestimation
	class Sequence
		def initialize(@array, @l)
		end

		def definite
			array = @array
			l = @l
			array << -1.0

			sum = [0.0]

			array.size.times do |i|
				sum << sum[i] + array[i]
			end

			pair = [] of Array(Int32)
			startpoint = [] of Int32
			endpoint = sum.size

			(sum.size-2).times do |i|
				i = sum.size - i - 2
				if sum[i-1] < sum[i] && sum[i] > sum[i+1]
					startpoint << i
				elsif sum[i-1] > sum[i] && sum[i] < sum[i+1]
					if startpoint.size == 1
						endpoint = i
					else
						if (sum[startpoint[0]] - sum[endpoint]) >= (sum[startpoint[0]] - sum[i])
							# when startpoint~endpoint is good.
							if startpoint[0] - endpoint > l
								pair << [endpoint, startpoint[0]-1]
								startpoint = [ startpoint[1] ]
							else
								startpoint = [ startpoint[1] ]
								#end
							end
						else
							if (sum[startpoint[0]] - sum[i]) >= (sum[startpoint[1]] - sum[i])
								startpoint = [ startpoint[0] ]
							else
								startpoint = [ startpoint[1] ]
							end
						end
						endpoint = i 
					end
				end
			end

			if startpoint.size == 2
				if (sum[startpoint[0]] - sum[0]) >= (sum[startpoint[1]] - sum[0])
					if startpoint[0] - 0 > l
						newp = [0, startpoint[0]-1]
						pair << newp
					end
				else
					if startpoint[0] - endpoint > l
						newp = [endpoint, startpoint[0]-1]
						pair << newp
					end
					if startpoint[1] - 0 > l
						newp = [0, startpoint[1] -1]
						pair << newp
					end
				end

			elsif startpoint.size == 0

			else
				endpoint = 0 if endpoint > startpoint[0]
				if startpoint[0] - endpoint > l
					newp = [endpoint, startpoint[0]-1] 
					pair << newp
				end
			end

			pair
		end

		def pair_dist_list(pair)
			# expect pair is sorted.
			score = [] of Int32
			pair.each_cons(2) do |a|
				score << a[0][0] - a[1][1] - 1
			end
			score.sort
		end

		def show
			pair = self.definite
			pair.each{|t| print "#{t[0]}\t#{t[1]}\n"}
			t = self.pair_dist_list(pair)
			leq5 = t.select{|item| item < 5}.size
			leq10 = t.select{|item| item < 10 }.size
			print "# #{@l} #{leq5} #{leq10} #{pair.size} #{leq5 * 1.0 / pair.size} #{leq10 * 1.0 / pair.size}\n"
		end

    def self.intervaldefinete(array, l)
      seq = Sequence.new(array, l)
			seq.definite
    end
	end
end
