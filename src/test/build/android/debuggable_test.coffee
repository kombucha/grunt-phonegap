grunt = require 'grunt'
xmlParser = require 'xml2json'
path = require 'path'
helpers = require(path.join __dirname, '..', '..', '..', 'tasks', 'helpers')(grunt)

if helpers.canBuild 'android'
  exports.phonegap =
    '<application android:debuggable> in AndroidManifest.xml should match config.androidDebuggable': (test) ->
      test.expect 1
      data = grunt.config.get 'phonegap.config.androidDebuggable'

      if grunt.util.kindOf(data) == 'function'
        androidApplicationName = data()
      else
        androidApplicationName = data

      xml = grunt.file.read 'test/phonegap/platforms/android/AndroidManifest.xml'
      manifest = xmlParser.toJson xml, object: true
      test.equal androidApplicationName, manifest['manifest']['application']['android:debuggable'], 'android:debuggable value should match'
      test.done()
