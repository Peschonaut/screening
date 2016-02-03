applicant = ->
  return Applicants.findOne()

Template.Home.helpers
  applicant: applicant

  numberOfVotes: ->
    applicant()?.results?.length or 0

  isUserFlagged: ->
    return Applicants.findOne()?.flagged == true

Template.Home.events
  'click #submit': ->
    ratingObject =
      gpa: document.getElementById("gpa").value
      workexperience: document.getElementById("workexperience").value
      extracurricular: document.getElementById("extracurricular").value
      overall: document.getElementById("overall").value
      speaksGermanFluently: document.getElementById("canSpeakGermanFluently").checked
      isExtraordinary: document.getElementById("isAnExtraordinaryPerson").checked
      isFromWHU: document.getElementById("isFromWHU").checked
      gpaSystem: document.getElementById("gradeSystem").value
      ratedBy: Meteor.userId()

    inputIsOk = true
    if parseInt(document.getElementById("gpa").value) > 5 || parseInt(document.getElementById("gpa").value) < 1 || document.getElementById("gpa").value == ""
      alert "Invalid gpa"
      inputIsOk = false
    if parseInt(document.getElementById("workexperience").value) > 8 || parseInt(document.getElementById("workexperience").value) < 1 || document.getElementById("workexperience").value == ""
      alert "Invalid workexperience"
      inputIsOk = false
    if parseInt(document.getElementById("extracurricular").value) > 5 || parseInt(document.getElementById("extracurricular").value) < 1 || document.getElementById("extracurricular").value == ""
      alert "Invalid extracurricular"
      inputIsOk = false
    if parseInt(document.getElementById("overall").value) > 2 || parseInt(document.getElementById("overall").value) < -2 || document.getElementById("overall").value == ""
      alert "Invalid overall"
      inputIsOk = false
    if inputIsOk
      #console.log 'ratingObject', ratingObject
      Meteor.call("conductOneRatingWithRatingObject", String(applicant()._id), ratingObject)

      remarks = document.getElementById("remarks").value

      #console.log 'remarks', remarks
      Meteor.call("updateRemarksForApplicant", String(applicant()._id), String(remarks))

      location.reload()
      #console.log 'clicked submit', String(applicant()._id)

  'click #trash': ->
    Meteor.call("markApplicantAsTrash", String(applicant()._id), 'General')
    location.reload()
    #console.log 'clicked trash'

  'click #flag': ->
    remarks = prompt 'Why do you want to flag this applicant?'
    Meteor.call("markApplicantAsFlagged", String(applicant()._id), remarks)
    location.reload()
    #console.log 'clicked flag'

  'click #unflag': ->
    Meteor.call("markApplicantAsUnflagged", String(applicant()._id))
    Router.go('home')
    #console.log 'clicked unflag'

  'click #skip': ->
    location.reload()
    #console.log 'clicked skip'

Template.Home.rendered = ->
  #console.log 'rendered'
  document.getElementById("gpa").value = applicant().curdegree
  #resize pdf canvas
  w = Math.max(document.documentElement.clientWidth, window.innerWidth || 0)
  h = Math.max(document.documentElement.clientHeight, window.innerHeight || 0)

  document.getElementById("pdf_content")?.width = w/2
  document.getElementById("pdf_content")?.height = h - 80
  #resize remarks box
  ratingheaderHeight = document.getElementById("ratingheader").clientHeight
  ratingheaderFooter = document.getElementById("ratingfooter").clientHeight
  optimalRemarksHeight = h - 225 - ratingheaderHeight - ratingheaderFooter
  #document.getElementById("ratingremarks")?.height = optimalRemarksHeight
