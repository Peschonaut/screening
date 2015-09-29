applicant = ->
  #console.log Applicants.find({}, {sort: {_id: 1}})?.fetch()?[0]
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

    #console.log 'ratingObject', ratingObject
    Meteor.call("conductOneRatingWithRatingObject", applicant()._id, ratingObject)

    remarks = document.getElementById("remarks").value

    #console.log 'remarks', remarks
    Meteor.call("updateRemarksForApplicant", applicant()._id,remarks)

    location.reload()
    #console.log 'clicked submit', applicant()._id

  'click #trash': ->
    Meteor.call("markApplicantAsTrash", applicant()._id, 'General')
    location.reload()
    #console.log 'clicked trash'

  'click #whutrash': ->
    Meteor.call("markApplicantAsTrash", applicant()._id, 'WHU')
    location.reload()
    #console.log 'clicked whutrash'

  'click #flag': ->
    Meteor.call("markApplicantAsFlagged", applicant()._id)
    location.reload()
    #console.log 'clicked flag'

  'click #unflag': ->
    Meteor.call("markApplicantAsUnflagged", applicant()._id)
    Router.go('home')
    #console.log 'clicked unflag'

  'click #skip': ->
    location.reload()
    #console.log 'clicked skip'

Template.Home.rendered = ->
  #console.log 'rendered'
  #resize pdf canvas
  w = Math.max(document.documentElement.clientWidth, window.innerWidth || 0)
  h = Math.max(document.documentElement.clientHeight, window.innerHeight || 0)

  document.getElementById("pdf_content")?.width = w/2
  document.getElementById("pdf_content")?.height = h - 135
  #resize remarks box
  ratingheaderHeight = document.getElementById("ratingheader").clientHeight
  ratingheaderFooter = document.getElementById("ratingfooter").clientHeight
  optimalRemarksHeight = h - 225 - ratingheaderHeight - ratingheaderFooter
  #document.getElementById("ratingremarks")?.height = optimalRemarksHeight
