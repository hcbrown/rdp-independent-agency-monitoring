library(dplyr)
library(janitor)
library(reshape2)

# reading in only the agency info
agencies <- read.csv("data/RDP Independent Agency Monitoring - Current make-up.csv",nrows = 30,na.strings = c("N/A",""))[0:5]

## CHAIRS

# reading in only the chairs
chairs <- read.csv("data/RDP Independent Agency Monitoring - Current make-up.csv",nrows = 30,na.strings = c("N/A",""))

# rename 'chair' variable to 'member_name'
colnames(chairs)[6] <- 'member_name'

# cleaning up the column names
chairs <- clean_names(chairs)
# selecting only relevant columns
chairs <- chairs[,c(1,6:9,46)]

# creating the boolean variable 'chair'
chairs$chair <- TRUE

# function to extract the symbols from 'member.name' and create a new variable with 'party.affiliation'
dem_symbols <- function(x) {
  ifelse(grepl("[a-z]\\*{2}(\\s|$)", x),"Democrat", NA)
}

chairs$party_affiliation <- sapply(chairs$member_name,dem_symbols)

## OTHER MEMBERS

other_seats <- read.csv("data/RDP Independent Agency Monitoring - Current make-up.csv",nrows = 30,na.strings = c("N/A",""))[,c(1,10:46)]

# cleaning up the column names
other_seats <- clean_names(other_seats)

# function to automate extraction of members
extract_members <- function(df, cols, party) {
  temp <- df[,cols]
  colnames(temp) <- colnames(chairs)[1:6]
  temp$chair <- FALSE
  temp$party_affiliation <- party
  return(temp)
}

dem1 <- extract_members(other_seats,c(1:5,38),"Democrat")
dem2 <- extract_members(other_seats,c(1,6:9,38),"Democrat")
gop1 <- extract_members(other_seats,c(1,10:13,38),"Republican")
gop2 <- extract_members(other_seats,c(1,14:17,38),"Republican")
dem3 <- extract_members(other_seats,c(1,18:21,38),"Democrat")
gop3 <- extract_members(other_seats,c(1,22:25,38),"Republican")

## COMBINE EVERYTHING

all_members <- rbind(chairs,dem1,dem2,dem3,gop1,gop2,gop3)

# remove all rows with NA for 'member_name'
all_members <- subset(all_members,!is.na(member_name))

# move agency to second column to emphasize each row is an observation of a member
all_members <- all_members[, c(2, 1, 3:8)]


rm(other_seats,chairs,dem1,dem2,dem3,gop1,gop2,gop3)
