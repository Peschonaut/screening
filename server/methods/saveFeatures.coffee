Meteor.methods
  conductOneRatingWithRatingObject: (_id, ratingObject) ->
    check _id, String
    check ratingObject, Object
    #console.log 'conductOneRatingWithRatingObject', _id, ratingObject
    Applicants.update { _id: _id }, $push: 'results': ratingObject

  updateRemarksForApplicant: (_id, remarks) ->
    check _id, String
    check remarks, String
    #console.log 'updateRemarksForApplicant', _id, remarks
    Applicants.update { _id: _id }, $set: 'results_remarks': remarks

  markApplicantAsTrash: (_id, comment) ->
    check _id, String
    #console.log 'markApplicantAsTrash', _id
    trashObject =
      markedAsTrashBy: Meteor.userId()
      comment: comment
    Applicants.update { _id: _id }, $push: 'results': trashObject
    Applicants.update { _id: _id }, $push: 'results': trashObject
    Applicants.update { _id: _id }, $push: 'results': trashObject

  markApplicantAsFlagged: (_id) ->
    check _id, String
    #console.log 'markApplicantAsFlagged', _id
    Applicants.update { _id: _id }, $set: 'flagged': true
    Applicants.update { _id: _id }, $set: 'flaggedBy': Meteor.userId()

  markApplicantAsUnflagged: (_id) ->
    check _id, String
    #console.log 'markApplicantAsUnflagged', _id
    Applicants.update { _id: _id }, $set: 'flagged': false
    Applicants.update { _id: _id }, $set: 'unflaggedBy': Meteor.userId()
