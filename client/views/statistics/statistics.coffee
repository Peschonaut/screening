# Meteor.subscribe 'AllApplicants'
Template.Statistics.helpers
  "remainingScreens": ->
    allApplicants = Applicants.find()?.fetch()
    neededTotalScreens = allApplicants?.length * 3
    console.log 'neededTotalScreens', neededTotalScreens
    totalScreenings = 0
    for applicant in allApplicants
      applicantDoc = Applicants.findOne(applicant._id)
      screenings = applicantDoc?.results?.length
      if !screenings?
        screenings = 0
      if applicantDoc?.flagged == true
        screenings = 3
      if screenings > 3
        screenings = 3
      totalScreenings += screenings

    console.log 'totalScreenings', totalScreenings
    neededTotalScreens-totalScreenings
