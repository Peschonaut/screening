@Applicants = new Mongo.Collection 'applicants'

if Meteor.isServer
  # XXX Temporary permission
  Applicants.allow
    insert: -> true
