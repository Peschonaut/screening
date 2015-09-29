# XXX Temporary publication
Meteor.publish 'AllApplicants', ->
  Applicants.find()

Meteor.publish 'OneApplicant', ->
  #Select an Applicant
  applicant = Applicants.findOne({$and: [{'results': {$exists: false}}, {$or: [{blockedUntil: {$exists: false}}, {blockedUntil: {$lte: +new Date()}}]}, $or: [{flagged : {$exists: false}},{flagged: false}]]})
  if !applicant
    applicant = Applicants.findOne({$and: [{'results.1': {$exists: false}}, {$or: [{blockedUntil: {$exists: false}}, {blockedUntil: {$lte: +new Date()}}]}, $or: [{flagged : {$exists: false}},{flagged: false}]]})
  if !applicant
    applicant = Applicants.findOne({$and: [{'results.2': {$exists: false}}, {$or: [{blockedUntil: {$exists: false}}, {blockedUntil: {$lte: +new Date()}}]}, $or: [{flagged : {$exists: false}},{flagged: false}]]})
  if !applicant
    applicant =
      _id: "we are done"
  #console.log 'applicant published', applicant
  #Set the applicant as blocked until x+10m
  timestamp = +new Date() + 60*1000 #in ms
  Applicants.update { _id: applicant._id }, $set: 'blockedUntil': timestamp
  #build cursor
  @added('applicants', applicant._id, applicant)
  #return
  @ready()

Meteor.publish 'AllFlaggedApplicants', ->
  Applicants.find(flagged:true)

Meteor.publish 'OneSpecificApplicant', (_id) ->
  check _id, String
  Applicants.find(_id)
