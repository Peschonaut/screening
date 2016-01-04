Template.Analytics.helpers
  users: ->
    users = Meteor.users.find().fetch()
    for user in users
      if !user.profile?.role?
        user.profile?.role = 'user'
      if !user.profile?
        user.profile = {}
        user.profile?.role = 'user'
      user.emailAddress = user.emails?[0]?.address
    if users.length then users else null

  numberOfScreenings: (user) ->
    numberOfScreenings = 0
    numberOfScreenings += Applicants.find({"results.0.ratedBy":user[0]._id})?.fetch()?.length
    numberOfScreenings += Applicants.find({"results.1.ratedBy":user[0]._id})?.fetch()?.length
    numberOfScreenings += Applicants.find({"results.2.ratedBy":user[0]._id})?.fetch()?.length

    numberOfScreenings

  averages: (user) ->
    allScreenings = []
    allScreenings = _.union(allScreenings, Applicants.find({"results.0.ratedBy":user[0]?._id})?.fetch())
    allScreenings = _.union(allScreenings, Applicants.find({"results.1.ratedBy":user[0]?._id})?.fetch())
    allScreenings = _.union(allScreenings, Applicants.find({"results.2.ratedBy":user[0]?._id})?.fetch())

    gpaAverage = 0
    workExAverage = 0
    extracurricularAverage = 0
    overallAverage = 0
    userAverage = 0

    for screening in allScreenings
      screeningresult = screening.results[0]
      if !screeningresult?
        screeningresult = screening.results[1]
      if !screeningresult?
        screeningresult = screening.results[2]
      gpaAverage += parseFloat(screeningresult.gpa/allScreenings.length)
      workExAverage += parseFloat(screeningresult.workexperience/allScreenings.length)
      extracurricularAverage += parseFloat(screeningresult.extracurricular/allScreenings.length)
      overallAverage += parseFloat(screeningresult.overall/allScreenings.length)

    resultString = ""
    resultString += "G: "+ gpaAverage
    resultString += " W: "+ workExAverage
    resultString += " E: "+ extracurricularAverage
    resultString += " O: "+ overallAverage

    return resultString

  kindness: (user) ->
    allScreenings = []
    allScreenings = _.union(allScreenings, Applicants.find({"results.0.ratedBy":user[0]?._id})?.fetch())
    allScreenings = _.union(allScreenings, Applicants.find({"results.1.ratedBy":user[0]?._id})?.fetch())
    allScreenings = _.union(allScreenings, Applicants.find({"results.2.ratedBy":user[0]?._id})?.fetch())

    gpaAverage = 0
    workExAverage = 0
    extracurricularAverage = 0
    overallAverage = 0
    userAverage = 0

    for screening in allScreenings
      screeningresult = screening.results[0]
      if !screeningresult?
        screeningresult = screening.results[1]
      if !screeningresult?
        screeningresult = screening.results[2]
      gpaAverage += parseFloat(screeningresult.gpa/allScreenings.length)
      workExAverage += parseFloat(screeningresult.workexperience/allScreenings.length)
      extracurricularAverage += parseFloat(screeningresult.extracurricular/allScreenings.length)
      overallAverage += parseFloat(screeningresult.overall/allScreenings.length)

    return Math.floor(parseFloat(gpaAverage+workExAverage+extracurricularAverage+overallAverage/4)*1000)/1000
