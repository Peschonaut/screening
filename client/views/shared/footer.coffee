Template.Footer.helpers

  year: ->
    new Date().getFullYear()

Template.Footer.events

  'click #logout': ->
    Meteor.logout()
