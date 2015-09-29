Schemas.User = new SimpleSchema
  emails:
    type: [ Object ]
    optional: true
  'emails.$.address':
    type: String
    regEx: SimpleSchema.RegEx.Email
  'emails.$.verified':
    type: Boolean
  profile:
    type: Object
    optional: true
    blackbox: true
  services:
    type: Object
    optional: true
    blackbox: true
  # Force value to be current date (on server) upon insert
  # and prevent updates thereafter.
  createdAt:
    type: Date
    autoValue: ->
      if @isInsert
        return new Date
      else if @isUpsert
        return { $setOnInsert: new Date }
      else
        @unset()
    autoform:
      omit: true
