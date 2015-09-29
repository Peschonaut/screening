Meteor.methods
  saveUser: (user) ->
    check user, Object

    Meteor.users.update { _id: user._id }, $set: 'profile.role': user.role
