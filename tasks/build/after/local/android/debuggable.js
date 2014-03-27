(function() {
  var debuggable, path, xmldom;

  xmldom = require('xmldom');

  path = require('path');

  module.exports = debuggable = function(grunt) {
    var helpers;
    helpers = require('../../../../helpers')(grunt);
    return {
      set: function(fn) {
        var doc, dom, isDebuggable, manifest, manifestPath, phonegapPath;
        dom = xmldom.DOMParser;
        isDebuggable = helpers.config('androidDebuggable');
        phonegapPath = helpers.config('path');
        manifestPath = path.join(phonegapPath, 'platforms', 'android', 'AndroidManifest.xml');
        manifest = grunt.file.read(manifestPath);
        grunt.log.writeln("Setting application name in '" + manifestPath + "' to " + isDebuggable);
        doc = new dom().parseFromString(manifest, 'text/xml');
        doc.getElementsByTagName('application')[0].setAttribute('android:debuggable', isDebuggable);
        grunt.file.write(manifestPath, doc);
        if (fn) {
          return fn();
        }
      }
    };
  };

}).call(this);
