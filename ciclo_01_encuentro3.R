library(googlesheets4)
library(gmailr)
library(tidyverse)

# if didn't configure before
gm_auth_configure(path = "gmailr_credentials.json")


#df <- read_csv("lista.csv")
df <- read_sheet("https://docs.google.com/spreadsheets/d/13TJs8gvHN6MZBUcLy49A_ujiCcf5ZlaZeJbiZECupwQ/edit#gid=173808074")
#df <- df[2:nrow(df),] #cuando sin querer le mandaste ya al primero
txt <- read_tsv("ciclo_01_encuentro3.txt",
                col_names = FALSE) %>% 
  unlist(use.names = FALSE)
# collapse to a length 1 vector
txt <- paste0(txt, collapse = "\n")

msgs <- list()
for (i in seq_along(1:nrow(df))) {
  
  m <- paste0("¡Hola ", df$Name[i], "!")
  m <- paste0(m, txt)
  
  msgs[[i]] <- gm_mime() %>%
    gm_to(df$EmailAddress[i]) %>%
    gm_from("talleresopensource@gmail.com") %>%
    gm_html_body(body = m) %>%
    gm_subject("Talleres Open Source - Encuentro 3 Arduino")
}

# explore text
gm_create_draft(msgs[[1]])


# send the messages
#lapply(msgs,
#       function(x) send_message(x))
