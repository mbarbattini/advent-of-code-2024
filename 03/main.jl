input = open("03/input.txt", "r") |> (f->read(f, String))

allMatches = eachmatch(r"mul\(\d{1,3},\d{1,3}\)", input)

score = 0
for m in allMatches
    left, right = split(m.match, ",")
    cleanedLeft = replace(left, r"\D" => "") |> (f->parse(Int, f))
    cleanedRight = replace(right, r"\D" => "") |> (f->parse(Int, f))
    score += cleanedLeft * cleanedRight
    println("$(left) $(right)")
end
score