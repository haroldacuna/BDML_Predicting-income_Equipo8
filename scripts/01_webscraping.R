#Cargue Base de datos
#Paquetes
require(pacman)
p_load(tidyverse, 
       rvest,
       httr,  
       jsonlite,
       ) 
url <- "https://ignaciomsarmiento.github.io/GEIH2018_sample/"
links <- read_html(url) %>% html_nodes(xpath="/html/body/div/div/div[2]/ul") %>%
  html_nodes("a") %>%
  html_attr("href")
links_pags <- paste0(url, links)
l1  <- data.frame(links_pags)
url_pag <- c()
for (i in 1:10){
  urli <- paste0("https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_", i , ".html")
  url_pag <- c(url_pag,urli)
  }
GEIH <- c()
for (i in 1:10){
  gyh <- url_pag[i] %>%
    read_html() %>% 
    html_table()
  GEIH[[i]] <- gyh[[1]]  
}
# Concatenar todas las tablas en un solo dataframe
GEIH_df <- bind_rows(GEIH)
