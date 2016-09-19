applicant = ->
  return Applicants.findOne()

Template.Home.helpers
  applicant: applicant

  numberOfVotes: ->
    applicant()?.results?.length or 0

  isUserFlagged: ->
    return Applicants.findOne()?.flagged == true

  settings: (key, subkey) ->
    settings = Settings.findOne()
    object = _.find settings.fields, (elem) ->
      elem._id == key
    object?[subkey]

  humanReadableBounds: (key) ->
    # console.log 'key', key
    settings = Settings.findOne()
    object = _.find settings.fields, (elem) ->
      elem._id == key
    humanReadableBounds = String(object.min)
    humanReadableBounds += ' - '
    humanReadableBounds += String(object.max)

Template.Home.events
  'click #submit': ->
    settings = Settings.findOne()

    ratingObject =
      # gpa: document.getElementById("gpa").value
      softFact1: document.getElementById("softFact1").value
      softFact2: document.getElementById("softFact2").value
      softFact3: document.getElementById("softFact3").value
      softFact4: document.getElementById("softFact4").value
      checkbox1: document.getElementById("checkbox1").checked
      checkbox2: document.getElementById("checkbox2").checked
      checkbox3: document.getElementById("checkbox3").checked
      # gpaSystem: document.getElementById("gradeSystem").value
      remarks: document.getElementById("remarks").value
      university: document.getElementById("university").value
      ratedBy: Meteor.userId()

    inputIsOk = true

    # if parseInt(document.getElementById("gpa").value) > 5 || parseInt(document.getElementById("gpa").value) < 1 || document.getElementById("gpa").value == ""
    #   alert "Invalid gpa"
    #   inputIsOk = false

    softFacts = ['softFact1', 'softFact2', 'softFact3', 'softFact4']
    _.each softFacts, (softFact) ->
      if parseInt(document.getElementById(softFact)?.value) > settings[softFact]?.max || parseInt(document.getElementById(softFact)?.value) < settings[softFact]?.min || document.getElementById(softFact)?.value == ""
        alert "Invalid "+ softFact
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
  document.getElementById("gpa")?.value = applicant().curdegree
  #resize pdf canvas
  w = Math.max(document.documentElement.clientWidth, window.innerWidth || 0)
  h = Math.max(document.documentElement.clientHeight, window.innerHeight || 0)

  document.getElementById("pdf_content")?.width = w/2
  document.getElementById("pdf_content")?.height = h - 80
  #resize remarks box
  ratingheaderHeight = document.getElementById("ratingheader")?.clientHeight
  ratingheaderFooter = document.getElementById("ratingfooter")?.clientHeight
  optimalRemarksHeight = h - 225 - ratingheaderHeight - ratingheaderFooter
  #document.getElementById("ratingremarks")?.height = optimalRemarksHeight
