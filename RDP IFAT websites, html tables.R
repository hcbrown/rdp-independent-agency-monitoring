## *** RDP Independent Federal Agency Monitoring *** ###

# Load data file for merged personnel
personnelmerge <- read.csv("~/Documents/CEPR/revolving door/RDPMergedpersonnel.csv")

# Rename columns
library(data.table)
setnames(personnelmerge, c("Term.Status", "Term.Expires", "Must.Vacate.Seat.By", "Nomination.Status", "Latest.Action", "Dated.Received.from.President", "Replaced..Replacing", "Additional.Notes"), c("Term Status", "Term Expires", "Must Vacate Seat By", "Nomination Status", "Latest Action", "Date Received from President", "Replaced/ Replacing", "Additional Notes")) 

# Convert CSV data to HTMLizable data tables
datatable(personnelmerge)

## Export to HTML

# Load data file for agency info
agencyinfo <- read.csv("~/Documents/CEPR/revolving door/RDPAgencyinfo.csv")

# Rename columns
setnames(agencyinfo, c("Voting.Members", "Appointed.members..subject.to.Senate.confirmation.for.THIS.post", "Enough.for.quorum.", "Political.balance.required.", "Senate.Committee.with.Jurisdiction", "Republican.Vacancies", "Democrat.Vacancies", "Serving.expired.terms", "Republican.Serving.Expired.Terms", "Democrat.Serving.Expired.Terms", "Pending.nominations"), c("Voting Members", "Appointed Members (requiring Senate confirmation for THIS seat)", "Enough for quorum?", "Political balance required?", "Senate Committee with Jurisdiction", "Republican Vacancies", "Democrat Vacancies", "Serving Expired Terms", "Republicans Serving Expired Terms", "Democrats Serving Expired Terms", "Pending Nominations")) 

# Convert CSV data to HTMLizable data table
datatable(agencyinfo)

## Export to HTML 