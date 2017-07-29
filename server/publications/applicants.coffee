# XXX Temporary publication
Meteor.publish 'AllApplicants', ->
  Applicants.find()

Meteor.publish 'OneApplicant', ->
  #Select an ApplicantresultCount
  resultCount = Settings.findOne()?.resultCount
  currentUserIsAdmin = (Meteor.users.findOne(this.userId)?.profile?.role == "admin")
  if currentUserIsAdmin
    applicant = Applicants.findOne({$and: [{'results': {$exists: false}}, {$or: [{blockedUntil: {$exists: false}}, {blockedUntil: {$lte: +new Date()}}]}, $or: [{flagged : {$exists: false}},{flagged: false}]]})
    if !applicant
      for i in [1..resultCount-1]
        queryIndexString = "results."+String(i)
        qry = {}
        qry[queryIndexString] = {$exists: false}
        console.log 'qry', qry
        if !applicant
          applicant = Applicants.findOne({$and: [qry, {$or: [{blockedUntil: {$exists: false}}, {blockedUntil: {$lte: +new Date()}}]}, $or: [{flagged : {$exists: false}},{flagged: false}]]})
        if applicant
          break;
    if !applicant
      applicant =
        _id: "we are done"
  else
    for i in [1..resultCount-1]
      queryIndexString = "results."+String(i)
      qry = {}
      qry[queryIndexString] = {$exists: false}
      allAdmins = Meteor.users.find({"profile.role": "admin"}).fetch()
      allAdminIds = _.pluck allAdmins, '_id'
      adminQry = {}
      adminQueryIndexString = "results."+String(i-1)+".ratedBy"
      adminQry[adminQueryIndexString] = {$in: allAdminIds}
      console.log 'adminQry', adminQry
      # console.log 'qry', qry
      if !applicant
        applicant = Applicants.findOne({$and: [adminQry, qry, {$or: [{blockedUntil: {$exists: false}}, {blockedUntil: {$lte: +new Date()}}]}, $or: [{flagged : {$exists: false}},{flagged: false}]]})
      if applicant
        break;
    if !applicant
      applicant =
        _id: "we are done"
  timestamp = +new Date() + 60*1000 #in ms
  Applicants.update { _id: applicant._id }, $set: 'blockedUntil': timestamp
  @added('applicants', applicant._id, applicant)
  @ready()

Meteor.publish 'AllFlaggedApplicants', ->
  Applicants.find(flagged:true)

Meteor.publish 'OneSpecificApplicant', (_id) ->
  check _id, String
  Applicants.find(parseInt(_id))
