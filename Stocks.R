
### Loading required libraries ###
library('rvest')

# Initializing the quote vector which will be used to store the stock quotes.
quote_vector <- NULL

# Initializing a vector containing the stocks' ticker symbols and a vector with the corresponding website links.
name_vector <- c('ALV', 'SAP', 'CON', 'DAI', 'BAY', 'XGOLD', 'KOL', 'MSCI JAP', 'SXP')
source_vector <- c('https://kurse.boerse.ard.de/ard/kurse_einzelkurs_uebersicht.htn?i=113403',
                   'https://kurse.boerse.ard.de/ard/kurse_einzelkurs_uebersicht.htn?i=107820',
                   'https://kurse.boerse.ard.de/ard/kurse_einzelkurs_uebersicht.htn?i=98754',
                   'https://kurse.boerse.ard.de/ard/kurse_einzelkurs_uebersicht.htn?i=107742',
                   'https://kurse.boerse.ard.de/ard/kurse_einzelkurs_uebersicht.htn?i=100580',
                   'https://kurse.boerse.ard.de/ard/kurse_einzelkurs_uebersicht.htn?i=6184617',
                   'https://kurse.boerse.ard.de/ard/kurse_einzelkurs_uebersicht.htn?i=9991077',
                   'https://kurse.boerse.ard.de/ard/etf_einzelkurs_uebersicht.htn?i=10454462',
                   'https://kurse.boerse.ard.de/ard/etf_einzelkurs_uebersicht.htn?i=44008064'
                   )

# Pulling the data by calling tags from the website's HTML code and inserting it into a vector.
for (address in source_vector) {
       url <- address
       webpage <- read_html(url)
       data_html <- html_nodes(webpage,'.big')
       data_stock <- html_text(data_html)
       stock_quote <- data_stock[1]
       #print(stock_quote)
       quote_vector <- c(quote_vector, stock_quote)
}

# Creating a data frame out of the name vector and the quote vector.
final_data <- data.frame(name_vector, quote_vector)

# Naming the rows by the name vector.
row.names(final_data) <- final_data$name_vector

# Deleting the no-obsolete name vector.
final_data$name_vector <- NULL

# Writing the data frame into a csv file.
write.table(final_data, file = '/file_path/dest_file.csv', sep = ',', col.names = FALSE)