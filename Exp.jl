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

#Que te jale el archivo en donde estás

data_dir = joinpath(@__DIR__, "data")
data = CSV.read(joinpath(data_dir, "gemahlener-cafe.asc"), DataFrame;
skipto=9, delim="\t", missingstring="?", threaded=false, silencewarnings=true)
display(data)
