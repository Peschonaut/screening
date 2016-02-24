# May be public for everyone
Meteor.publish null, ->
  Settings.find()
