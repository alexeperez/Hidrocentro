######################################
#### Score Sociodemografico - ui.R ##
######################################

library(shiny)

shinyUI(fixedPage( # standard shiny layout, controls on the
  # left, output on the right
  #titlePanel("Score Sociodemográfico"), # give the interface a title
  HTML("<body style=background:##FAFAFA> </body>"),
    #HTML("<body style=background:gray> </body>"),
  #tags$hr(),
  
#--------------------------- fixed row 1 logos---------------------------------#
  fixedRow(
  HTML("<hr color=SteelBlue noshade=noshade />"),
         column(width=3,offset = 0,
                tags$img(src = "logohidro.png", width = "190px", height = "70px",border="1")
         ),
         column(width=5,offset = 0,
         HTML("<div align=center> <font color=SteelBlue face=Arial size=5> Informe de Ensayos 
              Metrológicos. </font> </div>")
         ),
         column(width=3,offset = 0,
                tags$img(src = "logo_ssl_ult.jpeg", width = "210px", height = "75px",border="1") 
         )
  ),    
  HTML("<hr color=SteelBlue noshade=noshade />"),

#--------------------- fixed row 2 grafico comparacion-------------------------#  
# Informacion medidor
HTML("<div align=left> <b> <font color=SteelBlue face=Cambria size=3>
     Información del Medidor: </font> </b> </div>"),
  fixedRow(
  sidebarPanel(width=2,
    #HTML("<font color=SteelBlue face=Arial size=2> Modelo: </font>"),
    textInput(inputId="mod", label = "Modelo:",value = "MULTIMAG"),

    #HTML("<font color=SteelBlue face=Arial size=2> Serie: </font>"),
    textInput(inputId="serie", label = "Serie:",value = "14005998"),
    
    #HTML("<font color=SteelBlue face=Arial size=2> Diámetro: </font>"),
    textInput(inputId="diam", label = "Diámetro:",value = "15mm"),
    
    #HTML("<font color=SteelBlue face=Arial size=2> Clase: </font>"),
    textInput(inputId="clase", label = "Clase:",value = "B")
),

  column(width=5,offset = 0,  
    plotOutput(outputId="graf1", width = 495, height = 280),
    HTML("<b><font color=SteelBlue face=Arial size=2> Se analiza la diferencia entre los valores 
            del medidor patrón y del medidor del usuario. </a> </font> </b>")
    ),

  column(width=2,offset = 1,
           HTML("<b> <font color=SteelBlue face=Cambria size=3> Análisis: </font> </b>"),
           
           HTML("<p> <img src=analisis.jpg width = 90 height = 80 align=left>
           <font color=SteelBlue face=Cambria size=2> Se genera el gráfico del error porcentual
            entre los valores del medidor patrón y los del medidor del usario.
           </font> <p>"),
           submitButton("Analizar")
                
     )
),

#------------------ fixed row 3 tabla descrip comparacion----------------------#
HTML("<div align=left> <b> <font color=SteelBlue face=Cambria size=3> 
     Caudal (l/h): </font> </b> </div>"),
fixedRow(
    sidebarPanel(width = 2,
        #HTML("<font color=SteelBlue face=Arial size=2> Qmin: </font>"),
        numericInput(inputId="qmin", label = "Qmin:",value = 30),
        #HTML("<font color=SteelBlue face=Arial size=2> Qt: </font>"),
        numericInput(inputId="qt", label = "Qt:",value = 120),
        #HTML("<font color=SteelBlue face=Arial size=2> Qn: </font>"),
        numericInput(inputId="qn", label = "Qn:",value = 1500),
        #HTML("<font color=SteelBlue face=Arial size=2> Qmax: </font>"),
        numericInput(inputId="qmax", label = "Qmax:",value = 3000)
        ),
    
column(width=5,offset = 0,
       # tabla descriptivos error
       plotOutput(outputId="graf2", width = 540, height = 120),
       
       # medidor aceptable
       fixedRow(
           column(width=2, offset = 2,
              HTML("<img src=medidor.jpg width = 90 height = 80 align=left>")
              ),
           column(width=5, offset = 2,
              tags$h5("Medidor aceptado?", style = "color:red",align="center"),
              tags$h2(textOutput("medidor"),style = "color:red",align="center")
              )
       ),
       tags$hr(),
       
       # Tipo de medicion volumen mayor en medidor patron
       HTML("<div align=left> <b> <font color=SteelBlue face=Cambria size=3>
      Volumen en m3: </font> </b> </div>"),
       
       radioButtons("vm3", label ="", choices = c("mayor en medidor patrón"="mayor",
                    "menor en medidor patrón"="menor"), selected="mayor")
       ),

column(width=2,offset = 1,
       HTML("<b> <font color=SteelBlue face=Cambria size=3> Generar Informe: </font> </b>"),
       HTML("<p> <img src=report.png width = 90 height = 80 align=left>
           <font color=SteelBlue face=Cambria size=2> Se genera el reporte automático
            con la información proporcionada. </font> <p>"),
       
       #actionButton("generar",label = "Informe",icon = icon("list-alt",lib="glyphicon")),
       #submitButton("GENERAR"),
       #tags$h6(textOutput("reportermd"), style = "color:white",align="center")
       #tags$h6(textOutput("reporternw"), style = "color:white",align="center")
       #downloadButton('downloadReport', label="Descargar")
       downloadButton('downloadReportrnw', label="Descargar")
       )
),

#------------------------ Datos ensayo medidor patron -------------------------#
HTML("<b> <font color=SteelBlue face=Cambria size=3> Mediciones Medidor Patrón: </font> </b>"),
HTML("<hr> </hr>"),
fixedRow(
column(width=1,
       HTML("<b> <font face=Arial size=3> Lectura </font> </b>"),
       HTML("<b> <font face=Cambria size=2> Inicial: </font> </b>"),
       HTML("<br> </br>"),
       HTML("<br> </br>"),
       HTML("<b> <font face=Cambria size=2> Final: </font> </b>")
),
column(width=2,
       #HTML("<font color=SteelBlue face=Arial size=2> Qmin: </font>"),
       numericInput("mpqmini",label ="Qmin:",value = 0),
       numericInput("mpqminf",label ="",value = 0)
       ),

column(width=2,
       #HTML("<font color=SteelBlue face=Arial size=2> Qt: </font>"),
       numericInput("mpqti",label ="Qt:",value = 0),
       numericInput("mpqtf",label ="",value = 0)
       ),
column(width=2,
       #HTML("<font color=SteelBlue face=Arial size=2> Qn: </font>"),
       numericInput("mpqni",label ="Qn:",value = 0),
       numericInput("mpqnf",label ="",value = 0)
       ),
column(width=2,
       #HTML("<font color=SteelBlue face=Arial size=2> Qmax: </font>"),
       numericInput("mpqmaxi",label ="Qmax:",value = 0),
       numericInput("mpqmaxf",label ="",value = 0)
       )
),

# Datos ensayo medidor usuario
HTML("<b> <font color=SteelBlue face=Cambria size=3> Mediciones Medidor Usuario: </font> </b>"),
HTML("<hr> </hr>"),
fixedRow(
column(width=1,
       HTML("<b> <font face=Arial size=3> Lectura </font> </b>"),
       HTML("<b> <font face=Cambria size=2> Inicial: </font> </b>"),
       HTML("<br> </br>"),
       HTML("<br> </br>"),
       HTML("<b> <font face=Cambria size=2> Final: </font> </b>")
),    
column(width=2,
    #HTML("<font color=SteelBlue face=Arial size=2> Qmin: </font>"),
    numericInput("muqmini",label ="Qmin:",value = 0),
    numericInput("muqminf",label ="",value = 0)
),
column(width=2,
    #HTML("<font color=SteelBlue face=Arial size=2> Qt: </font>"),
    numericInput("muqti",label ="Qt:",value = 0),
    numericInput("muqtf",label ="",value = 0)
),
column(width=2,
    #HTML("<font color=SteelBlue face=Arial size=2> Qn: </font>"),
    numericInput("muqni",label ="Qn:",value = 0),
    numericInput("muqnf",label ="",value = 0)
),
column(width=2,
    #HTML("<font color=SteelBlue face=Arial size=2> Qmax: </font>"),
    numericInput("muqmaxi",label ="Qmax:",value = 0),
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
                 del documento para de esta manera disminuir el tiempo empleado. Adicionalmente
                 presenta cierta información estadística sobre las diferencias entre los valores del
                 medidor del usuario respecto a los valores del medidor patrón considerando distintos
                 niveles de caudal.</font>"),
            tags$br(),
            tags$br(),
            
            HTML("<font color=#2E2E2E face=Arial size=2> La interfaz fue desarrollada para que de una
                 manera sencilla el usuario pueda hacer uso de la misma. Los pasos que se deben seguir 
                 son los siguientes:</font>"),
                
            HTML("<font color=#2E2E2E face=Arial size=2> <ol>
                <li> Ingrese la lectura inicial y final para cada caudal para el medidor patrón y 
                        para el medidor del usuario.</li>
                <li> Clic en <font color=SteelBlue> Analizar </font> para la generación del gráfico.</li> 
                <li> Clic en <font color=SteelBlue> Descargar </font> para generar el informe de ensayos en un archivo pdf.</li>
                </ol> </font>"),
            
            
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


