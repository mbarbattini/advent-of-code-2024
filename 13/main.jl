function solve(filename; scale=1)
	inputRaw = open(filename) |> (f->read(f, String))

	nums = parse.(Int, map(m -> m.match, collect(eachmatch(r"\d+", inputRaw))))

	score = 0.0

	for i in range(1, length(nums), step=6)
		ax, ay, bx, by, prizeX, prizeY = nums[i:i+5]
		A = [[ax bx]; [ay by]]
		b = [[prizeX + scale]; [prizeY + scale]]

		a,b = inv(A) * b

		tolerance = 0.0001

		if abs(a - round(a)) < tolerance && abs(b - round(b)) < tolerance
			score += 3*a + b
			# println("valid: $(round(a)),$(round(b))")
		end
	end

	println("score is $(Int(score))")

end

@time solve(raw"13/input.txt")

@time solve(raw"13/input.txt", scale=10000000000000)
