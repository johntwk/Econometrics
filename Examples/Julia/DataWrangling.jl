#=
This shows some data wrangling using the Card data
on returns to education
=#

##
using DelimitedFiles, CSV, DataFrames, DataFramesMeta
card = CSV.read("../Data/card.csv")
display(first(card,6))


##
# add some variables
card[:lnwage] = round.(log.(card[:wage]), digits=4) # round to save storage space
card[:expsq] = (card[:exper].^2)/100
card[:agesq] = card[:age].^2

##
# select the ones we want
cooked = @select(card, :lnwage, :educ, :exper, :expsq, :black, :south, :smsa, :age, :agesq, :nearc4 )
display(first(cooked,6))

##
# write as CSV
CSV.write("cooked.csv", cooked)

##
# write as plain ASCII
data = convert(Matrix{Float32}, cooked)
writedlm("cooked.txt", data)

# for binary write, see JLD.jl and Feather.jl
