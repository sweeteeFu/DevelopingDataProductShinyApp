#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Exploring Exponential Distribution in R"),
  
  # Sidebar with a slider input for number of exponentials 
  sidebarLayout(
    sidebarPanel(
       sliderInput("noOfExponentials", "Number of Exponential (n):",
                   min = 1, max = 520, value = 40, step = 10),
       checkboxInput("show_CurveSampleMean","Show curve formed by sample mean with its standard deviation",value=TRUE),
       checkboxInput("show_CurveTheoreticalMean","Show curve formed by theoretical mean with its standard deviation",value=TRUE),
       checkboxInput("show_Mean","Show Mean Details",value=FALSE),
       checkboxInput("show_Variance","Show Variance Details",value=FALSE),
       br(),
       tableOutput("myMeanTable"),
       tableOutput("myVarianceTable")
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       h5("This project focuses on exploring the exponential distribution in R and have a comparison on it with the Central Limit Theorem. This project will investigate the distribution of averages of n exponentials and compare its distributions over a thousand simulations."),
       h5("Use the two controls on the left pane to select:"),
       h5("1. the sample size - the number of exponential"),
       h5("2. the simulation outcome"),
       plotOutput("plot1"),
       em("Blue bar - the density of the data set, Violet vertical line - the sample mean, Dotted cyan vertical line - the theoretical mean"),
       br(),
       br(),
       strong("Through the histogram plotted, it potrays that the distribution approaches the sample normal as the sample size, n increases."),
       strong("It can be observed that the curves plotted are very close to each other and they are normally distributed and this proves that the Central Limit Theory is met.")
       
      
       
    )
  )
))
