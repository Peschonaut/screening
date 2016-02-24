Meteor.methods
  conductOneRatingWithRatingObject: (_id, ratingObject) ->
    check _id, String
    check ratingObject, Object
    _id = parseInt(_id)
    #console.log 'conductOneRatingWithRatingObject', _id, ratingObject
    Applicants.update { _id: _id }, $push: 'results': ratingObject

  updateRemarksForApplicant: (_id, remarks) ->
    check _id, String
    check remarks, String
    # console.log 'updateRemarksForApplicant', _id, remarks
    Applicants.update { _id: parseInt(_id) }, $set: 'results_remarks': remarks

  markApplicantAsTrash: (_id, comment) ->
    check _id, String
    check comment, String
    #console.log 'markApplicantAsTrash', _id
    trashObject =
      markedAsTrashBy: Meteor.userId()
      comment: comment
    resultCount = Settings.findOne()?.resultCount
    for i in [0..resultCount-1]
      Applicants.update { _id: parseInt(_id) }, $push: 'results': trashObject

  markApplicantAsFlagged: (_id, reason) ->
    check _id, String
    check reason, String
    #console.log 'markApplicantAsFlagged', _id
    resultCount = Settings.findOne()?.resultCount
    for i in [0..resultCount-1]
      Applicants.update { _id: parseInt(_id) }, $set: 'flagged': true

  markApplicantAsUnflagged: (_id) ->
    check _id, String
    #console.log 'markApplicantAsUnflagged', _id
    Applicants.update { _id: parseInt(_id) }, $set: 'flagged': false
    Applicants.update { _id: parseInt(_id) }, $set: 'unflaggedBy': Meteor.userId()
