library(shiny)
library(ggplot2)
shinyServer(function(input, output) {
        
        output$distName <- renderUI({
                if(input$distribution=="Central Normal"){
                        wellPanel(sliderInput('quantile', 'Quantile',
                                              value = 0.75, min = 0.001, max = 1)
                        )
                }else{ wellPanel(numericInput("df","Degrees of freedom",1,min=1,step=1),
                                 sliderInput('quantile', 'Quantile',value = 0.75, 
                                             min = 0.001, max = 1)
                )
                }
        })
        
        x <- NULL; y<- NULL; df <- NULL
        reactiveFeatures <- reactive({
                if(input$distribution=="Central Normal"){
                        x <<- seq(-4,4,0.001)
                        y <<- dnorm(x)
                }else{
                        df <<- as.numeric(input$df)
                        x <<- seq(-4,4,0.001)
                        y <<- dt(x,df=df)     
                }
        })
        
        output$newDistribution <- renderPlot({
                reactiveFeatures()
                plot(x,y,type="l",lwd=2)
                grid(5,5,col="black")
                q <- as.numeric(input$quantile)
                
                if(input$distribution=="Central Normal"){
                        x1 <- qnorm(q)
                        y1 <- dnorm(qnorm(q))
                        lines(c(x1,x1),c(0,y1),col="red",lwd=2,lty=2)
                        lines(c(0-1*4,x1),c(y1,y1),col="red",lwd=2,lty=2)
                        points(x1,y1,col="red",pch=19)
                        text(2,max(y),paste("Mean = ",0),pos=4)
                        text(2,max(y)*0.9,paste("Sd = ",1),pos=4)
                        text(2,max(y)*0.8,paste("pnorm = ",
                                                         round(pnorm(q)),3),pos=4)
                        text(2,max(y)*0.7,paste("qnorm = ",
                                                         round(x1,3)),pos=4)
                        text(2,max(y)*0.6,paste("dnorm = ",
                                                         round(y1,3)),pos=4)
                }else{
                        x1 <- qt(q,df=df)
                        y1 <- dt(qt(q,df=df),df=df)
                        lines(c(x1,x1),c(0,y1),col="red",lwd=2,lty=2)
                        lines(c(0-1*4,x1),c(y1,y1),col="red",lwd=2,lty=2)
                        points(x1,y1,col="red",pch=19)
                        text(2,max(y),paste("df = ",df),pos=4)
                        text(2,max(y)*0.9,paste("pt = ",
                                                round(pt(q,df=df),3)),pos=4)
                        text(2,max(y)*0.8,paste("qt = ",
                                                round(x1,3)),pos=4)
                        text(2,max(y)*0.7,paste("dnorm = ",
                                                round(y1,3)),pos=4)
                        
                }
        })        
} 
)


