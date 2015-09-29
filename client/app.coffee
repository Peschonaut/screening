App.login = (email, password, callback) ->
  onLogin = (error) -> callback?(error)
  Meteor.loginWithPassword(email, password, onLogin)


App.logout = (callback) ->
  onLogout = (error) -> callback?(error)
  Meteor.logout(onLogout)


# Template helpers
@Helpers = {};


Helpers.capitalize = (string) ->
  string.charAt(0).toUpperCase() + string.slice(1);


Helpers.nl2br = (str) ->
  # Source: http://stackoverflow.com/a/2919363
  (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1'+ '<br>' +'$2');


Helpers.niceDate = (date) ->
  date = moment.min moment(date), moment() # prevent 'in a few seconds' glitch
  diff = moment().diff(date, 'hours')

  if diff <= 12 then date.fromNow()
  else if diff <= 48 then date.calendar()
  else date.format('MM/DD/YYYY h:mma')


Handlebars.registerHelper(key, helper) for key, helper of Helpers
