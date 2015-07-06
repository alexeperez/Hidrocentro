######################################
#### Score Sociodemografico - ui.R ##
######################################

library(shiny)

shinyUI(fixedPage( # standard shiny layout, controls on the
  # left, output on the right
  #titlePanel("Score Sociodemográfico"), # give the interface a title
  HTML("<body style=background:##FAFAFA> </body>"),
  #tags$hr(),
  
#--------------------------- fixed row 1 logos---------------------------------#
  fixedRow(
  HTML("<hr color=SteelBlue noshade=noshade />"),
         column(width=3,offset = 0,
            tags$img(src = "logo_ssl_ult.jpeg", width = "220px", height = "85px",border="1")  
         ),
         column(width=6,offset = 0,
         HTML("<div align=center> <font color=SteelBlue face=arial size=5> Informe de Ensayos 
              Metrológicos </font> </div>")
         ),
         column(width=3,offset = 0,
            tags$img(src = "logohidro.png", width = "190px", height = "70px",border="1")  
         )
  ),    
  HTML("<hr color=SteelBlue noshade=noshade />"),

#--------------------- fixed row 2 grafico comparacion-------------------------#  
# Informacion medidor
HTML("<div align=left> <b> <font color=SteelBlue face=Cambria size=3>
     Información del Medidor: </font> </b> </div>"),
  fixedRow(
  sidebarPanel(width=3,
    #HTML("<font color=SteelBlue face=Arial size=2> Modelo: </font>"),
    textInput(inputId="mod", label = "Modelo",value = "MULTIMAG"),

    #HTML("<font color=SteelBlue face=Arial size=2> Serie: </font>"),
    textInput(inputId="serie", label = "Serie",value = "14005998"),
    
    #HTML("<font color=SteelBlue face=Arial size=2> Diámetro: </font>"),
    textInput(inputId="diam", label = "Diámetro",value = "15mm"),
    
    #HTML("<font color=SteelBlue face=Arial size=2> Clase: </font>"),
    textInput(inputId="clase", label = "Clase",value = "B")
),

  column(width=6,offset = 0,  
    plotOutput(outputId="graf1", width = 500, height = 300),
    HTML("<font color=SteelBlue face=Arial size=2> Se analiza la diferencia entre los valores 
            del medidor patrón y del medidor del usuario. </a> </font>")
    ),

  column(width=2,offset = 0,
           HTML("<b> <font color=SteelBlue face=Cambria size=3> Análisis </font> </b>"),
           
           HTML("<p> <img src=analisis.jpg width = 90 height = 80 align=left>
           <font color=SteelBlue face=Cambria size=2> Se genera el gráfico del error porcentual
            entre los valores del medidor patrón y los del medidor del usario.
           </font> <p>"),
           submitButton("ANALIZAR")
                
     )
),

#------------------ fixed row 3 tabla descrip comparacion----------------------#
HTML("<div align=left> <b> <font color=SteelBlue face=Cambria size=3> 
     Caudal (l/h): </font> </b> </div>"),
fixedRow(
    sidebarPanel(width = 3,
        #HTML("<font color=SteelBlue face=Arial size=2> Qmin: </font>"),
        numericInput(inputId="qmin", label = "Qmin",value = 30),
        #HTML("<font color=SteelBlue face=Arial size=2> Qt: </font>"),
        numericInput(inputId="qt", label = "Qt",value = 120),
        #HTML("<font color=SteelBlue face=Arial size=2> Qn: </font>"),
        numericInput(inputId="qn", label = "Qn",value = 1500),
        #HTML("<font color=SteelBlue face=Arial size=2> Qmax: </font>"),
        numericInput(inputId="qmax", label = "Qmax",value = 3000)
        ),
    
column(width=6,offset = 0,
       # tabla descriptivos error
       plotOutput(outputId="graf2", width = 550, height = 130)
       ),

column(width=2,offset = 0,
       HTML("<b> <font color=SteelBlue face=Cambria size=3> Generar Informe </font> </b>"),
       HTML("<p> <img src=report.png width = 90 height = 80 align=left>
           <font color=SteelBlue face=Cambria size=2> Se genera el reporte automático
            con la información proporcionada. </font> <p>"),
       submitButton("GENERAR")
       )
),


#------------------------ Datos ensayo medidor patron -------------------------#
HTML("<b> <font color=SteelBlue face=Cambria size=3> Mediciones Medidor Patrón </font> </b>"),
fixedRow(
sidebarPanel(width=3,
    #HTML("<font color=SteelBlue face=Arial size=2> Qmin: </font>"),
    numericInput("mpqmini",label ="Qmin",value = 0),
    numericInput("mpqminf",label ="",value = 0)
),
sidebarPanel(width=3,
    #HTML("<font color=SteelBlue face=Arial size=2> Qt: </font>"),
    numericInput("mpqti",label ="Qt",value = 0),
    numericInput("mpqtf",label ="",value = 0)
),
sidebarPanel(width=3,
    #HTML("<font color=SteelBlue face=Arial size=2> Qn: </font>"),
    numericInput("mpqni",label ="Qn",value = 0),
    numericInput("mpqnf",label ="",value = 0)
),
sidebarPanel(width=3,
    #HTML("<font color=SteelBlue face=Arial size=2> Qmax: </font>"),
    numericInput("mpqmaxi",label ="Qmax",value = 0),
    numericInput("mpqmaxf",label ="",value = 0)
)
),

# Datos ensayo medidor usuario
HTML("<b> <font color=SteelBlue face=Cambria size=3> Mediciones Medidor Usuario </font> </b>"),
fixedRow(
sidebarPanel(width=3,
    #HTML("<font color=SteelBlue face=Arial size=2> Qmin: </font>"),
    numericInput("muqmini",label ="Qmin",value = 0),
    numericInput("muqminf",label ="",value = 0)
),
sidebarPanel(width=3,
    #HTML("<font color=SteelBlue face=Arial size=2> Qt: </font>"),
    numericInput("muqti",label ="Qt",value = 0),
    numericInput("muqtf",label ="",value = 0)
),
sidebarPanel(width=3,
    #HTML("<font color=SteelBlue face=Arial size=2> Qn: </font>"),
    numericInput("muqni",label ="Qn",value = 0),
    numericInput("muqnf",label ="",value = 0)
),
sidebarPanel(width=3,
    #HTML("<font color=SteelBlue face=Arial size=2> Qmax: </font>"),
    numericInput("muqmaxi",label ="Qmax",value = 0),
    numericInput("muqmaxf",label ="",value = 0)
)
),


tags$hr(),
mainPanel( # all of the output elements go in here
       tabsetPanel(
           tabPanel("Informe de Ensayos Metrológicos",
                
            HTML("<font color=#2E2E2E face=Arial size=2> La Interfaz desarrollada para la generación
                 automática del <font color=SteelBlue> Informe de Ensayos Metrológicos </font>
                 es una heramienta técnica que tiene como propósito automatizar el proceso de elaboración
                 del documento para de esta manera disminuir el tiempo tiempo empleado. Adicionalmente
                 presenta cierta información estadística sobre las diferencias entre los valores teóricos
                 esperados respecto a los observados en un rango de fechas determinado.</font>"),
            tags$br(),
            tags$br(),
            
            HTML("<font color=#2E2E2E face=Arial size=2> La interfaz fue desarrollada para que de una
                 manera sencilla el usuario pueda hacer uso de la misma. Los pasos que se deben seguir 
                 son los siguientes:</font>"),
                
            tags$ol(
                tags$li("Clic en Choose File. Seleccione el archivo con la información a utilizar."), 
                tags$li("Seleccione el rango de fechas en las cuales desea analizar."), 
                tags$li("Clic en Generar Informe. Para generar el informe de ensayos en un archivo pdf.")
            ),
            
            HTML("<font color=#2E2E2E face=Arial size=2> En lo que se refiere a las <font color=SteelBlue> 
                 herramientas informáticas </font> utilizadas en la generación del modelo podemos enumerar 
                 las siguientes:</font>"),
            tags$ol(
                tags$li(tags$a(href="http://www.r-project.org", "R Project")), 
                tags$li(tags$a(href="http://www.rstudio.com", "Rstudio")),
                tags$li(tags$a(href="http://www.ef-prime.com/products/ranalyticflow_en/index.html", "R Analytic Flow"))
                )
           )
          
             ),
HTML("<hr color=SteelBlue noshade=noshade />"),           
  
# Redes sociales
   HTML("<font color=SteelBlue face=Arial size=1.7> Siguenos en</font>"),
   HTML("<a href=https://www.facebook.com/sourcestatlab> <img src=facebook.png width = 50 height = 35> </a> 
        <font color=SteelBlue face=Arial size=1.7>  Source Stat Lab EC </font>"),
   HTML("<a href=https://twitter.com/SourceStatLab> <img src=twitter.jpg width = 50 height = 45> </a>
        <font color=SteelBlue face=Arial size=1.7> @SourceStatLabEC </font>"),
HTML("<hr color=SteelBlue noshade=noshade />")
  )
 )
)


