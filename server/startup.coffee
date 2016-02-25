Meteor.startup ->
  if process.env.SETTINGS_RESET?
    Settings.remove {}
  settingsExist = Settings.findOne()?
  if !settingsExist
    settings =
      '_id': Random.id()
      'logoUrl': process.env.LOGO_URL or '/img/nyc.png'
      'allowScreening': process.env.ALLOW_SCREENING or false
      'resultCount': process.env.RESULT_COUNT or 3
      'fields': [
          {
            'label': process.env.LABELCB1 or 'Is the applicant from WHU?'
            '_id': 'checkbox1'
          }
          {
            'label': process.env.LABELCB2 or 'Is the applicant an extraordinary person?'
            '_id': 'checkbox2'
          }
          {
            'label': process.env.LABELCB3 or 'Can the applicant speak German fluently?'
            '_id': 'checkbox3'
          }
          {
            'label': process.env.LABELSF1 or 'WORK EXPERIENCE'
            '_id': 'softFact1'
            'max': process.env.MAXSF1 or 5
            'min': process.env.MINSF1 or 1
          }
          {
            'label': process.env.LABELSF2 or 'EXTRACURRICULAR'
            '_id': 'softFact2'
            'max': process.env.MAXSF2 or 5
            'min': process.env.MINSF2 or 1
          }
          {
            'label': process.env.LABELSF3 or 'INERNATL'
            '_id': 'softFact3'
            'max': process.env.MAXSF3 or 5
            'min': process.env.MINSF3 or 1
          }
        ]
    Settings.insert settings
