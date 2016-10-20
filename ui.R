shinyUI(pageWithSidebar(
  headerPanel("Simple Upload to GitHub"),
  sidebarPanel(
    fileInput("files", "Files to upload", multiple = TRUE)
  ),
  mainPanel(
    h3("Current files uploaded, all hyperlinked"),
    htmlOutput("curr_files"),
    h3("Files uploaded, all hyperlinked"),
    htmlOutput("out_info")
    
  )
))
