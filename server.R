library(git2r)
library(shiny)
library(shinyapps)
### make shiny max request size 30MB
options(shiny.maxRequestSize=30*1024^2)

shinyServer(function(input, output, session) {
  # output$filetable <- renderTable({
  upload_file = reactive({
    if (!is.null(input$files)) {
        # User has not uploaded a file yet
     
        files = input$files
        fnames = files$name
        
        types = files$type
        print(files)
        
        
    } else {
      
    }
      return(list(nii=nii, filename=outfile))
  })


  output$out_info <- renderText({
    res = upload_file()
    
  })
})
