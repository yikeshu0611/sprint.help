#' install
#'
#' @param token token
#'
#' @return install
#' @export
#'
install_sprint20b <- function(token){
    e <- tryCatch(detach("package:sprint20b", unload = TRUE),error=function(e) 'e')
    # check
    (td <- tempdir(check = TRUE))
    td2 <- '1'
    while(td2 %in% list.files(path = td)){
        td2 <- as.character(as.numeric(td2)+1)
    }
    (dest <- paste0(td,'/',td2))
    do::formal_dir(dest)
    dir.create(path = dest,recursive = TRUE,showWarnings = FALSE)
    (tf <- paste0(dest,'/sprint20b.zip'))

    if (do::is.windows()){
        download.file(url = 'https://codeload.github.com/zjsprint/sprint20b_win/zip/refs/heads/main',
                      destfile = tf,
                      mode='wb',
                      headers = c(NULL,Authorization = sprintf("token %s",token)))
        unzip(zipfile = tf,exdir = dest,overwrite = TRUE)
    }else{
        download.file(url = 'https://codeload.github.com/zjsprint/sprint20b_mac/zip/refs/heads/main',
                      destfile = tf,
                      mode='wb',
                      headers = c(NULL,Authorization = sprintf("token %s",token)))
        unzip(zipfile = tf,exdir = dest,overwrite = TRUE)
    }



    if (do::is.windows()){
        main <- paste0(dest,'/sprint20b_win-main')
        (sprint20b <- list.files(main,'sprint20b_',full.names = TRUE))
        (sprint20b <- sprint20b[do::right(sprint20b,3)=='zip'])
        (k <- do::Replace0(sprint20b,'.*sprint20b_','\\.zip','\\.tgz','\\.') |> as.numeric() |> which.max())
        unzip(sprint20b[k],files = 'sprint20b/DESCRIPTION',exdir = main)
    }else{
        main <- paste0(dest,'/sprint20b_mac-main')
        sprint20b <- list.files(main,'sprint20b_',full.names = TRUE)
        sprint20b <- sprint20b[do::right(sprint20b,3)=='tgz']
        k <- do::Replace0(sprint20b,'.*sprint20b_','\\.zip','\\.tgz','\\.') |> as.numeric() |> which.max()
        untar(sprint20b[k],files = 'sprint20b/DESCRIPTION',exdir = main)
    }

    (desc <- paste0(main,'/sprint20b'))
    check_package(desc)

    install.packages(pkgs = sprint20b[k],repos = NULL,quiet = FALSE)
    message('Done(sprint20b)')
    x <- suppressWarnings(file.remove(list.files(dest,recursive = TRUE,full.names = TRUE)))
    invisible()
}


