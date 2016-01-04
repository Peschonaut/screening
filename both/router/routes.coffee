Router.configure
  notFoundTemplate: 'NotFound'
  loadingTemplate: 'Loading'
  templateNameConverter: 'upperCamelCase'
  routeControllerNameConverter: 'upperCamelCase'
  layoutTemplate: 'MasterLayout'

# For individual route configuration, see /client/controllers
Router.map ->
# Non-Administrative routes
  @route 'home',
  path: '/',
  waitOn: -> Meteor.subscribe 'OneApplicant'

  @route 'individual',
  path: '/flagged/:_id',
  template: 'Home'
  waitOn: -> Meteor.subscribe 'OneSpecificApplicant', Router.current().params._id

# Login route
  @route 'login', path: '/login'

# Administrative routes
  @route 'users', path: '/users'

  @route 'flagged',
  path: '/flagged',
  waitOn: -> Meteor.subscribe 'AllFlaggedApplicants'

  @route 'logs', path: '/logs'

  @route 'statistics',
  path: '/statistics',
  waitOn: -> Meteor.subscribe 'AllApplicants'

  @route 'analytics',
  path: '/analytics',
  waitOn: -> Meteor.subscribe 'AllApplicants'

# Static routes
  @route 'imprint', path: '/imprint'
  @route 'privacy', path: '/privacy'
  @route 'terms', path: '/terms'

### Require signing in for all routes, except:
Router.plugin 'ensureSignedIn',
  except: ['home', 'imprint', 'privacy', 'terms']
###
