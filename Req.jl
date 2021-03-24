#Requirements: 04/03/2021
#In this code is to set up all you need for running the main code
#From LABI, Laboratory of Mass Espectrometry, CINVESTAV, March 2021.

###############################################################
################### PACKAGE REQUIREMENTS ######################
###############################################################
#using Pkg
#using CSV
#using DataFrames
#using Plots
#using StatsPlots
using Pkg

#   CSV
try
    @eval import CSV
    println("CSV is installed")
catch
    println("CSV is not installed")
    Pkg.add("CSV")
end

#   DataFrames
try
    @eval import DataFrames
    println("DataFrames is installed")
catch
    println("DataFrames is not installed")
    Pkg.add("DataFrames")
end

#   Plots
try
    @eval import Plots
    println("Plots is installed")
catch
    println("Plots is not installed")
    Pkg.add("Plots")
end


#   Statistics
try
    @eval import Statistics
    println("Statistics is installed")
catch
    println("Statistics is not installed")
    Pkg.add("Statistics")
end
