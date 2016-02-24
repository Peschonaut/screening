Schemas.Settings = new SimpleSchema
  logoUrl:
    type: String
    optional: true
  allowScreening:
    type: Boolean
    optional: true
  resultCount:
    type: Number
    optional: true
  fields:
    type: [ Object ]
  "fields.$.label":
    type: String
  "fields.$._id":
    type: String
  "fields.$.max":
    type: Number
    optional: true
  "fields.$.min":
    type: Number
    optional: true
