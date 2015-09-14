spawn = require('child_process').spawn

module.exports =

  build: ->
    # start Hint
    atom.notifications.addInfo 'Build started', dismissable: true, detail: "Please do not load the project folder."

    # get Config Path
    path = atom.config.get('language-arma-atom.buildScript')
    if path is 'PROJECTFOLDER'
      path = atom.project.getPaths() + '\\tools\\build.py'

    buildProcess = spawn 'python', [path.replace(/%([^%]+)%/g, (_,n) -> process.env[n])]
    buildProcess.stdout.on 'data', (data) -> atom.notifications.addSuccess 'Build is Done' , dismissable: true, detail: data
    buildProcess.stderr.on 'data', (data) -> atom.notifications.addError 'Build cant Finish' , dismissable: true, detail: data

  make: ->
    atom.notifications.addInfo 'Make started', dismissable: true, detail: 'This may take some time.'

    # get Config Path
    path = atom.config.get('language-arma-atom.buildScript')
    if path is 'PROJECTFOLDER'
      path = atom.project.getPaths() + '\\tools\\make.py'

    buildProcess = spawn 'python', [path.replace /%([^%]+)%/g, (_,n) -> process.env[n]]
    buildProcess.stdout.on 'data', (data) -> atom.notifications.addSuccess 'Make is Done', dismissable: true, detail: data
    buildProcess.stderr.on 'data', (data) -> atom.notifications.addError "Make didn't finish", dismissable: true, detail: data
