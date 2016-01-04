Meteor.methods
  createExampleUser: ->
    Accounts.createUser
      email: 'test1337@test.test'
      password: 'test1234'

    console.log 'test@test.de', 'test1234'

  clearDb: ->
    Applicants.remove status:"academics"
    Applicants.remove status:"professionals"

  makeAdmin: ->
    Meteor.users.update {'_id':'D3cynMCPmakbbnMpy'}, $set: 'profile.role':'admin'
