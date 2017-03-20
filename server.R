#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$myMeanTable <-renderTable({
    set.seed(1)
    n<-input$noOfExponentials
    lambda<-0.2
    noOfSim<-1000
    simMeans<-NULL
    for(i in 1:noOfSim) simMeans<-c(simMeans,mean(rexp(n,lambda)))
    
    if(input$show_Mean){
      sampleMean<-mean(simMeans)
      theoreticalMean<-1/lambda
      df_mean<-setNames(data.frame(sampleMean,theoreticalMean,abs(theoreticalMean-sampleMean)),c("Sample Mean","Theoretical Mean","Diff in Means"))
      df_mean
    }else{
      df_mean<-setNames(data.frame("-","-","-"),c("Sample Mean","Theoretical Mean","Diff in Means"))
      df_mean
    }
  },digits = 5, align = "c")
  
  output$myVarianceTable <-renderTable({
    set.seed(1)
    n<-input$noOfExponentials
    lambda<-0.2
    noOfSim<-1000
    simMeans<-NULL
    for(i in 1:noOfSim) simMeans<-c(simMeans,mean(rexp(n,lambda)))
    
    if(input$show_Variance){
      sampleVar<-var(simMeans)
      theoreticalVar<-((1/lambda)/sqrt(n))^2
      df_var<-setNames(data.frame(sampleVar,theoreticalVar,abs(theoreticalVar-sampleVar)),c("Sample Variance","Theoretical Variance","Diff in Variance"))
      df_var
    }else{
      df_var<-setNames(data.frame("-","-","-"),c("Sample Variance","Theoretical Variance","Diff in Variance"))
      df_var
    }
  },digits = 5,align = "c")
  
  output$plot1 <- renderPlot({
    set.seed(1)
    n<-input$noOfExponentials
    lambda<-0.2
    noOfSim<-1000
    simMeans<-NULL
    for(i in 1:noOfSim) simMeans<-c(simMeans,mean(rexp(n,lambda)))
    
    sampleMean<-mean(simMeans)
    theoreticalMean<-1/lambda
    
    library(ggplot2)
    g<-ggplot(data.frame(y=simMeans),aes(x=y))
    g<-g+geom_histogram(aes(y=..density..),binwidth = 0.2, fill="blue",color="black")
    g<-g+geom_vline(xintercept=sampleMean, size=1.0,color="violet")
    g<-g+geom_vline(xintercept=theoreticalMean,size=1.0,color="cyan",linetype=10)
    g<-if(input$show_CurveSampleMean){
      g+stat_function(fun=dnorm,args=list(mean=sampleMean,sd=sd(simMeans)),color="red",size=1.5)
    }else{
      g
    }
    
    g<-if(input$show_CurveTheoreticalMean){
      g+stat_function(fun=dnorm,args=list(mean=theoreticalMean,sd=(1/lambda)/sqrt(n)),color="gold", size=1.5)
    }else{
      g       
    }
    
    g<-g+labs(title="Density of Observed Data from Exponential Distribution",x="Simulation Means", y="Density")
    g<-g+geom_rug()
    g
  })
  
})
