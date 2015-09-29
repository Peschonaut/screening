Meteor.methods
  'createNewUser': (newUser) ->
    check newUser, Object
    Accounts.createUser
      username: newUser.email
      email : newUser.email
      password : newUser.password
