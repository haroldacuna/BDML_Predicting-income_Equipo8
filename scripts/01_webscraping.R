#Paquetes

#Cargue Base de datos
#Paquetes
require(pacman)
p_load(tidyverse,# tidy-data 
       rvest, # For scraping
       httr,  # For scraping
       jsonlite, # For read Json data
       randomForest, # For predictive model assessment
       boot, # For predictive model assessment
       caret, # For predictive model assessment
       gridExtra, # arrange plots
       skimr, # summarize data 
       stargazer, #model viz and descriptive statistics
       AER,  # model viz format
       ) 
# guardar la URL
url <- "https://ignaciomsarmiento.github.io/GEIH2018_sample/"

# obtener los links de cada 
links <- read_html(url) %>% html_nodes(xpath="/html/body/div/div/div[2]/ul") %>%
  html_nodes("a") %>%
  html_attr("href")

links_pags <- paste0(url, links)

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

  

dff <- data.frame(GEIH)
write.csv(GEIH_df , "datos_taller1.csv", row.names = FALSE, sep = ";")
  







