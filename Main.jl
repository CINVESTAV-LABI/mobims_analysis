#Main: 08/02/2021
#This code was develop to analyze electron for electron impact mass spectrometry data
#Coded by Laura Rosina Torres Ortega
#From LABI, Laboratory of Mass Espectrometry, CINVESTAV, January 2021.

#########################################################################
##################     Import PACKAGES       #########################################
#########################################################################
using Pkg
using CSV
using DataFrames
using Plots
using StatsPlots

#########################################################################
##################     Import DATASET       #########################################
#########################################################################

#Read the data  

data_dir = joinpath(@__DIR__, "data")
data = CSV.read(joinpath(data_dir, "gemahlener-cafe.asc"), DataFrame;
skipto=9, delim="\t", missingstring="?", threaded=false, silencewarnings=true)


#Filtrate only ion info
n=ncol(data)/3
z = collect(1:n)*3
z= Int.(z)
ions = data[2:24,z]

#Change col names
#Put the ion names in a vector
y= []
for j in 1:length(z)
    x=("Ion_$j m/z")
    push!(y, x)
end
#Rename cols in the data frame
rename!(ions, Symbol.(y))


#Isonate Relative Time Column (s)
rtime = data[2:24,2]
start = rtime[1]

#Get the relative time in seconds
time_vector = []
for i in rtime,
    i=i/3600 + start
    push!(time_vector, i)
end

#Put the relative time with the ion data info in a single table to analyze
insertcols!(ions, 1, :RelativeTime => time_vector)

###############Plotting########################

#Plotting each ion behavior
no_ions = ncol(ions) - 1
for m in 1:no_ions
    xlabel!("Time (s)")
    ylabel!("Ion Current [A]")
    savefig("images/Plot$m.pdf")
end
