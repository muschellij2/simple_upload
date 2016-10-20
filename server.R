library(git2r)
library(shiny)
library(shinyapps)
### make shiny max request size 30MB
options(shiny.maxRequestSize=30*1024^2)
tdir = tempfile()
repo = git2r::clone(url = "https://github.com/muschellij2/kelly_uploads",
                    local_path = tdir)

pat = readLines("kelly_pat.txt")
Sys.setenv("KELLY_PAT" = pat)
cred = cred_token("KELLY_PAT")
curr_files = list.files(path = tdir)

shinyServer(function(input, output, session) {
  # output$filetable <- renderTable({
  hyperlinker = function(fname) {
    base_url = paste0("https://raw.githubusercontent.com/", 
                      "muschellij2/kelly_upload/gh-pages/")    
    refs = lapply(fname, function(x) {
      url = paste0(base_url, x)
      list(a(x, href = url), br())
    })
  }  
  upload_file = reactive({
    outfiles = NULL
    
    if (!is.null(input$files)) {
      # User has not uploaded a file yet
      
      files = input$files
      # fnames = files$name
      files$name = as.character(files$name)
      files$datapath = as.character(files$datapath)
      infiles = files$datapath
      outfiles = file.path(tdir, files$name)
      print(files)
      print(infiles)
      print(outfiles)
      file.copy(from = files$datapath,
                to = outfiles, overwrite = TRUE)
      print(files)
      git2r::add(repo, path = outfiles)
      mess = paste0("Uploading ", paste(files$name, collapse = ", "),
                    "files")
      git2r::commit(repo = repo, message = mess)
      git2r::push(repo, name = "origin", "refs/heads/gh-pages", 
                  credentials = cred)
      
    } 
    
    return(outfiles)
  })
  
  
  output$curr_files <- renderUI({
    if (length(curr_files) > 0) {
      res = basename(curr_files)
      res = hyperlinker(res)
      return(div(res))
    } else {
      return("")
    }
  })
  
  output$out_info <- renderUI({
    res = upload_file()
    if (length(res) > 0) {
      res = basename(res)
      res = hyperlinker(res)
      return(div(res))      
    } else {
      return("")
    }
  })
})
