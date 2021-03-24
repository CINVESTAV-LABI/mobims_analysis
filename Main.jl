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
using Statistics
using StatsBase

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
ions = data[1:24,z]

#Change col names
#Put the ion names in a vector
y= []
for j in 1:length(z)
    names=("Ion_$j m/z")
    push!(y, names)
end
#Rename cols in the data frame
rename!(ions, Symbol.(y))


#Isonate Relative Time Column (s)
rtime = data[1:24,2]
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
#First make "images" folder if its not already in your dir
folder=isdir("images")
if (folder==true)
    println("You already have the folder")
else
    mkdir("images")
end

#Plotting each ion behavior
no_ions = ncol(ions) - 1
for m in 1:10;
        plot(time_vector,ions[:, m+1], label="Ion $m")
        xlabel!("Time (s)")
        ylabel!("Ion Current [A]")
        savefig("images/Plot$m.pdf")
end

############################
function f(time,resp,p)
    # Moving average of  "resp" using "p"
    # as the window
    n = length(resp) # Number of elements of "resp"
    movavg = []#Array{Float64,1}(undef, n)]]# it will contain moving average
    timrep = []#Array{Float64,1}(undef, n)  # will contain the time
    a = 1 # Inicial value
    while((a+p) <= n)
      movavg = [movavg; mean(resp[a:(a+p-1)])]
      timrep = [timrep; median(time[a:(a+p-1)])]
      a = a + 1 # increments value of a # the result is a dataframe structure
    end
return DataFrame(time=timrep, ma=movavg)

end

Ion_10 = f(ions[:,"RelativeTime"], ions[:,"Ion_10 m/z"], 2)

#Smooting function vs real behavior
p10_b=plot(ions[:,"RelativeTime"],  ions[:,"Ion_10 m/z"], xlab="Time (h)",
    ylab="Ion Current (A)", label="Ion 10")
#points(Ion_10[:,"time"],Ion_10[:,"ma"])
p10_s= scatter(Ion_10[:,"time"],Ion_10[:,"ma"], xlab="Time (h)",
    ylab="Ion Current (A)", label="Smoothing, with p= 2, Ion 10") # Make a scatter plot
plot(p1, p2, layout = (2, 1), legend = false, label="Smoothing, with p= 2, Ion 10")


###########Update 23_03_21

#describe(ions)


##########
#using DynamicalSystems
#h_eom(x,p,t) = SVector{2}()


#ContinuousDynamicalSystem(eom, state, p [, jacobian [, J0]]; t0 = 0.0)
#DifferentialEquations.jl
