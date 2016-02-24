@Settings = new Mongo.Collection 'settings'
Settings.attachSchema Schemas.Settings

if Meteor.isServer
  Settings.allow
    insert: -> true
    update: -> true


Settings.helpers
  getLogoUrl: ->
    return @logoUrl

###
Example Settings Document
{
    "_id" : "56ce02dad4c63cba9987a05a",
    "logoUrl" : "http://uploads.webflow.com/53cbf9c046631a7b2828fc88/55c0aa7944fdd10d2d37049f_whu_idealab_logo.jpg",
    "allowScreening" : true,
    "resultCount": 3,
    "fields": [
    {
          "_id":"checkbox1",
          "label" : "Is the applicant from WHU?"
      },
      {
          "_id":"checkbox2",
          "label" : "Is the applicant an extraordinary person?"
      },
      {
          "_id":"checkbox3",
          "label" : "Can the applicant speak German fluently?"
      },
      {
          "_id":"softFact1",
          "label" : "WORK EXPERIENCE",
          "max" : NumberInt(5),
          "min" : NumberInt(1)
      },
      {
          "_id":"softFact2",
          "label" : "EXTRACURRICULAR",
          "max" : NumberInt(5),
          "min" : NumberInt(1)
      },
      {
          "_id":"softFact3",
          "label" : "OVERALL",
          "max" : NumberInt(5),
          "min" : NumberInt(1)
      }
    ]
}
###
