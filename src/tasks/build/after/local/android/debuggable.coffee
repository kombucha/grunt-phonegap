xmldom = require 'xmldom'
path = require 'path'

module.exports = debuggable = (grunt) ->
  helpers = require('../../../../helpers')(grunt)

  set: (fn) ->
    dom = xmldom.DOMParser
    isDebuggable = helpers.config 'androidDebuggable'

    phonegapPath = helpers.config 'path'

    manifestPath = path.join phonegapPath, 'platforms', 'android', 'AndroidManifest.xml'
    manifest = grunt.file.read manifestPath
    grunt.log.writeln "Setting application name in '#{manifestPath}' to #{isDebuggable}"
    doc = new dom().parseFromString manifest, 'text/xml'

    doc.getElementsByTagName('application')[0].setAttribute('android:debuggable', isDebuggable)

    grunt.file.write manifestPath, doc

    if fn then fn()
