# Screening
Screeningtool for screening applicants for student initiatives at WHU.
#####The default website port is 3000(you can specify a --port XX option)
#####The default mongodb port is 3001(or website+1)

# Setup
##### You need to have git already installed
For OSX and Linux
```
curl https://install.meteor.com/ | sh
cd ~
git clone https://github.com/Laymi/screening.git
cd screening
meteor
```
For Windows(just don't)
```
https://install.meteor.com/windows
Clone the git repository in some folder that you have RW permissions on
Open a command prompt, navigate to the folder and type 'meteor' to start the app
```
# Getting started
To use this tool you have to add the CVs of the applicants into the public/pdf folder and create corresponding documents in the database.
The \_id of the document should correspond to the filename of the CV. The file format should be pdf.

# Settings
All settings are set in one single document of the 'Settings' collection.
You can find all possible keys in the mup.json or the server/startup.coffee.
Changes can be applied by changing the document in the database itself or by setting the environment variables that are loaded (you can do so very easily by utilizing the mup configuration).

## Example JSON - Applicant
```
{
    "_id" : NumberInt(40111111),
    "first" : "Daniel",
    "last" : "Pesch",
    "salutation" : "Mr.",
    "predegree" : "4.0",
    "curdegree" : "4.0"
    // You can add more features if you want
    // The tool will create more subdocuments right here
}
```
The tool will then write the results of the screening into the applicant's document.
We use:
"results" as an array to save the application features (in this version gpa,workexperience,extracurricular and overall) in form of an object
"results_remarks" as a string to store the remarks data
"blockedUntil" as a number or double to store the UNIX timestamp of releasing the applicant to the system
"flagged" as a boolean to store the flagged state of the applicant
"flaggedBy" as a String to store the Meteor.userId() of the user who flagged an applicant
"unflaggedBy" as a String to store the Meteor.userId() of the user who unflagged an applicant
