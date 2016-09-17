# XXX Temporary publication
Meteor.publish 'AllApplicants', ->
  Applicants.find()

Meteor.publish 'OneApplicant', ->
  #Select an ApplicantresultCount
  resultCount = Settings.findOne()?.resultCount
  allApplicants = Applicants.find().fetch()
  self = this
  _.filter allApplicants, (applicant) ->
    notAnsweredByMe = true
    console.log 'applicant?.results', applicant?.results
    _.each applicant?.results, (result) ->
      console.log 'cmp', self.userId, result.ratedBy
      if result.ratedBy == self.userId
        console.log 'blocked self.userId', self.userId
        console.log 'blocked applicant', applicant
        notAnsweredByMe = false
    return notAnsweredByMe

  tempApplicants = new Mongo.Collection(null)
  _.each allApplicants, (applicant) ->
    applicant._id = String(applicant._id)
    tempApplicants.insert applicant

  console.log 'a', tempApplicants.find().fetch()

  if self.userId == "9D8GL8PPfprZEXBF9"
    applicant = tempApplicants.findOne({$and: [{'results': {$exists: false}}, {$or: [{blockedUntil: {$exists: false}}, {blockedUntil: {$lte: +new Date()}}]}, $or: [{flagged : {$exists: false}},{flagged: false}]]})
  else
    applicant = tempApplicants.findOne({$and: [{ "results.2": { $exists: false } }, { "results.0.ratedBy": "9D8GL8PPfprZEXBF9" }, {$or: [{blockedUntil: {$exists: false}}, {blockedUntil: {$lte: +new Date()}}]}, $or: [{flagged : {$exists: false}},{flagged: false}]]})
  if !applicant
    for i in [1..resultCount-1]
      queryIndexString = "results."+String(i)
      qry = {}
      qry[queryIndexString] = {$exists: false}
      # console.log 'qry', qry
      if !applicant
        if self.userId == "9D8GL8PPfprZEXBF9"
          applicant = tempApplicants.findOne({$and: [qry, {"results.2":{$exists: false}}, {$or: [{blockedUntil: {$exists: false}}, {blockedUntil: {$lte: +new Date()}}]}, $or: [{flagged : {$exists: false}},{flagged: false}]]})
        else
          applicant = tempApplicants.findOne({$and: [qry, {"results.2":{$exists: false}}, { "results.0.ratedBy": "9D8GL8PPfprZEXBF9" }, {$or: [{blockedUntil: {$exists: false}}, {blockedUntil: {$lte: +new Date()}}]}, $or: [{flagged : {$exists: false}},{flagged: false}]]})
      console.log 'b', applicant
      if applicant
        break;
  if !applicant
    applicant =
      _id: "we are done"
  timestamp = +new Date() + 60*1000 #in ms
  applicant._id = parseInt(applicant._id)
  Applicants.update { _id: applicant._id }, $set: 'blockedUntil': timestamp
  @added('applicants', applicant._id, applicant)
  @ready()

Meteor.publish 'AllFlaggedApplicants', ->
  Applicants.find(flagged:true)

Meteor.publish 'OneSpecificApplicant', (_id) ->
  check _id, String
  Applicants.find(parseInt(_id))
