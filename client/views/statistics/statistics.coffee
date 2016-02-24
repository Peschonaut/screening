# Meteor.subscribe 'AllApplicants'
Template.Statistics.helpers
  "remainingScreens": ->
    allApplicants = Applicants.find()?.fetch()
    resultCount = Settings.findOne()?.resultCount
    neededTotalScreens = allApplicants?.length * resultCount
    # console.log 'neededTotalScreens', neededTotalScreens
    totalScreenings = 0
    for applicant in allApplicants
      applicantDoc = Applicants.findOne(applicant._id)
      screenings = applicantDoc?.results?.length
      if !screenings?
        screenings = 0
      if applicantDoc?.flagged == true
        screenings = resultCount
      if screenings > 3
        screenings = resultCount
      totalScreenings += screenings

    # console.log 'totalScreenings', totalScreenings
    neededTotalScreens-totalScreenings
