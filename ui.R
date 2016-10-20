library(shinyIncubator)
shinyUI(pageWithSidebar(
  headerPanel("Online DICOM TO NIfTI Converter"),
  sidebarPanel(
    fileInput("files", "File data", multiple=TRUE, 
              accept = c("application/dicom", 
                         "application/zip",
                         "application/x-gzip")),
#     uiOutput("sld_window"),
    selectInput("dcmniicmd", "Which dcm2nii?", 
                choices =c("dcm2niix", "dcm2nii"),
                selected = "dcm2niix"),
    checkboxInput("viewimg", "View img?", TRUE),
    checkboxInput("gzipped", "gzip nii?", TRUE),
    textInput("niifname", "Filename of nii (no .nii on it)"),
    downloadButton('dlimg', 'Download NIfTI')
  ),
  mainPanel(
#     progressInit(),
    plotOutput("ortho"),
    p("Code on ", 
      a("GitHub", href="https://github.com/muschellij2/dcm2nii_shiny"))
  )
))