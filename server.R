######################################
# Comparación Consumos   - server.R ##
######################################

options(warn = -1)
library(ggplot2)
library(scales)
library(grid)
library(reshape2)
library(readxl)
library(rmarkdown)

#med <- read.table("clipboard", sep="\t",dec=",",header = F)
# funcion error de medicion
error <- function(med, mayor=TRUE){
    dif1 <- med[,2]-med[,1]
    dif2 <- med[,4]-med[,3]
    if(mayor==TRUE){
        dvm <- dif1-dif2
        er <- ifelse(dif2==0, 0, 100*(dvm/dif2))
    }else{
        dvm <- dif2-dif1
        er <- ifelse(dif1==0, 0, 100*(dvm/dif1))
    }
 return(er)
}
#error(med)

#------------------------------------------------------
#             Interfaz
#------------------------------------------------------
shinyServer(function(input, output) {
    
    # graf comp consumos 
    output$graf1 <- renderPlot({
        # Informacion medidor
        assign("modelo", input$mod, envir=.GlobalEnv)
        assign("serie", input$serie, envir=.GlobalEnv)
        assign("diametro", input$diam, envir=.GlobalEnv)
        assign("clase", input$clase, envir= .GlobalEnv)
        # Informacion caudales Q
        assign("qmin", input$qmin, envir= .GlobalEnv)
        assign("qt", input$qt, envir= .GlobalEnv)
        assign("qn", input$qn, envir= .GlobalEnv)
        assign("qmax", input$qmax, envir= .GlobalEnv)
        
        mpli<- c(input$mpqmini,input$mpqti,input$mpqni,input$mpqmaxi)
        mplf<- c(input$mpqminf,input$mpqtf,input$mpqnf,input$mpqmaxf)
        muli<- c(input$muqmini,input$muqti,input$muqni,input$muqmaxi)
        mulf<- c(input$muqminf,input$muqtf,input$muqnf,input$muqmaxf)
        med <- data.frame(mpli,mplf,muli,mulf)
        mayor <- FALSE
        if(input$vm3=="mayor") mayor <- TRUE
        er <- error(med, mayor)
        assign("error",round(er/100,2),envir=.GlobalEnv)
        
        # Informacion mediciones lectura inicial y final
        mediciones <- data.frame(med,er)
        colnames(mediciones)<- c(colnames(med),"error")
        assign("mediciones",mediciones,envir=.GlobalEnv)
        
           q0 <- c(input$qmin,input$qt,input$qn,input$qmax)
           # cambio escala
           q0[2] <- q0[2]*(0.325*q0[4]/120)
           q0[3] <- q0[3]*(0.75*q0[4]/1500)
           q <- q0[c(1,2,2,3,4)]
           lim <- c(rep(5,2),rep(2,3))
           d <- data.frame(q,lim)

           g <- ggplot(d, aes(x=q,y=lim))+
           geom_line(colour="gray99",size=1)+
           annotate("segment", x=d[1:3,1] ,y=-d[1:3,2], xend=d[c(2,3,5),1],
                        yend=-d[c(2,3,5),2], colour="gray99", size=0.7)+
           annotate("rect", xmin=d[c(1,3),1],ymin=-d[c(1,3),2], xmax=d[c(2,5),1],
                        ymax=d[c(2,5),2], fill="gray95",alpha=0.4)+
           
           annotate("rect", xmin=d[2:3,1],ymin=c(-d[2,2],d[3,2]), xmax=d[c(5,5),1],
                    ymax=c(-d[5,2],d[1,2]), fill="dodgerblue4",alpha=0.8)+
           annotate("rect", xmin=d[c(1,1),1],ymin=c(-d[1,2]-2,d[1,2]), xmax=d[c(5,5),1],
                    ymax=c(-d[1,2],d[1,2]+2), fill="dodgerblue4",alpha=0.8)+
           
           annotate("segment", x=d[1,1] ,y=0, xend=d[5,1], yend=0, colour="gray0",
                    size=0.5, linetype="dotted")+
           
           annotate("pointrange", x=d[-3,1], y=er, ymin=er, ymax=er,
                    colour = "red", size = 0.7, alpha=1)+
           annotate("segment", x=d[-c(3,5),1], y=er[-4], xend=d[-c(1,3),1], yend=er[-1],
                        colour = "red", size = 0.5, alpha=1)+
           labs(list(x="Caudal (l/h)", y="Error (%)"))+ theme_bw()+
           scale_y_continuous(breaks=seq(-100,100,2))+scale_x_continuous(breaks=d[-3,1],
                                               labels=c("Qmin", "Qt", "Qn", "Qmax")) 
               
    print(g)
    
    assign("grafico",g , envir = .GlobalEnv)
    

})
    
    
    # graf leyenda y estadisticas basicas
    output$graf2 <- renderPlot({
        mpli<- c(input$mpqmini,input$mpqti,input$mpqni,input$mpqmaxi)
        mplf<- c(input$mpqminf,input$mpqtf,input$mpqnf,input$mpqmaxf)
        muli<- c(input$muqmini,input$muqti,input$muqni,input$muqmaxi)
        mulf<- c(input$muqminf,input$muqtf,input$muqnf,input$muqmaxf)
        med <- data.frame(mpli,mplf,muli,mulf)
        mayor <- FALSE
        if(input$vm3=="mayor") mayor <- TRUE
        er <- error(med, mayor)
        

            desc <- data.frame(est=c("Min","Media","Max"), 
                               val=round(c(min(er),mean(er),max(er)),3))
            leg <- data.frame(legx=c(0,0), legy=c(0,1),Valor=c("Optimo","Observado"))
            g <- ggplot(leg, aes(x = legx, y=legy, color=Valor))+
                geom_point(size=10, shape=16)+ylim(c(-0.5,1.5)) +xlim(c(0,1.5))+
                scale_color_manual(values = c("gainsboro","dodgerblue4"))+
                theme_classic()+theme(text=element_blank(), axis.line=element_blank(),
                                      axis.ticks=element_blank(), legend.position="none")+
                annotate("text", x=c(0.25,0.275), y=c(0,1), label=c("Zona Rechazo", "Zona Aceptación"))+
                # Descriptivos
                annotate("rect", xmin=0.6, xmax=1.4,ymin=0.7, ymax=1.5, alpha=1,fill="dodgerblue4")+
                annotate("text", x=1, y=1.3, label="error medido",colour="gray96",size=6)+
                annotate("text", x=1, y=0.9, label="Estadísticos Descriptivos",colour="gray96",size=3)+
                annotate("rect", xmin=0.6, xmax=1.4,ymin=-0.3, ymax=0.2, alpha=1,fill="dodgerblue4")+
                annotate("text", x=c(0.75,1,1.25), y=rep(0,3), label=desc[,1],colour="gray96",size=5)+
                annotate("text", x=c(0.75,1,1.25), y=rep(0.5,3), label=desc[,2],colour="dodgerblue4",size=4)
            print(g)    
 
})
 

# Texto medidor aceptado o rechazado
output$medidor <- renderText({
        mpli<- c(input$mpqmini,input$mpqti,input$mpqni,input$mpqmaxi)
        mplf<- c(input$mpqminf,input$mpqtf,input$mpqnf,input$mpqmaxf)
        muli<- c(input$muqmini,input$muqti,input$muqni,input$muqmaxi)
        mulf<- c(input$muqminf,input$muqtf,input$muqnf,input$muqmaxf)
        med <- data.frame(mpli,mplf,muli,mulf)
        mayor <- FALSE
        if(input$vm3=="mayor") mayor <- TRUE
        er <- error(med, mayor)
        medidor <- "SI"
        if(abs(er[1]>5) | any(abs(er[2:length(er)])>2)) medidor <- "NO" 
    assign("aceptado", medidor, envir = .GlobalEnv)
    # guardamos .RData           
    save.image(file = "Hidro.RData") 
        
        paste(medidor)
               
})

# reporte rmd
output$reportermd <- renderText({
    if(as.numeric(input$generar)>0){
        load("Hidro.RData")
        render("reporte.Rmd", pdf_document())
        file.show("reporte.pdf")
        }
    paste("Ver en:", getwd())
})

# reporte rnw
# output$reporternw <- renderText({
#     if(as.numeric(input$generar)>0){
#         load("Hidro.RData")
#        system("xelatex -interaction=batchmode reporte ")
#         system("open reporte.pdf")
#         }
#     paste("Ver en:", getwd())
# })

output$downloadReport <- downloadHandler(
    filename = function() {
        paste('reporte-', Sys.Date(), '.pdf', sep='')
    },
    
    content = function(reporte) {
        library(rmarkdown)
        load("Hidro.RData")
        report <- render("reporte.Rmd", pdf_document())
        file.rename(report, reporte)
    }
)

output$downloadReportrnw <- downloadHandler(
    filename = function() {
        paste('reporte-', Sys.Date(), '.pdf', sep='')
    },
    
    content = function(reporte) {
        library(knitr)
        load("Hidro.RData")
        report <- knit2pdf("reporte.Rnw")
        file.rename(report, reporte)
    }
)


})
