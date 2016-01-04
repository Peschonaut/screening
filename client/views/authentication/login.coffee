Template.Login.helpers

Template.Login.events
  "click #loginUser": (data) ->
    event.preventDefault()

    data =
      email: document.getElementById('email').value
      password: document.getElementById('password').value

    Meteor.loginWithPassword data.email, data.password, (error) ->
      if error
        console.error 'login error ', error, 'for user ', data.email
      else
        console.error 'login successful for user ', data.email

    Router.go("/")
