# Meteor.subscribe 'AllApplicants'
Template.Settings.helpers
  settingsDoc: ->
    Settings.findOne()
