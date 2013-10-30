#
# * grunt-environment
# * https://github.com/logankoester/grunt-environment
# *
# * Copyright (c) 2013 Logan Koester
# * Licensed under the MIT license.
#
module.exports = (grunt) ->
  grunt.initConfig

    nodeunit:
        tests: ['test/*_test.js']

      coffee:
        tasks:
          expand: true
          cwd: 'src/tasks/'
          src: '**/*.coffee'
          dest: 'tasks/'
          ext: '.js'

        test:
          expand: true
          cwd: 'src/test/'
          src: '**/*.coffee'
          dest: 'test/'
          ext: '.js'

      clean:
        tasks: ['tasks']
        test: ['test']
        build: ['build.json']

      copy:
        test_fixtures:
          files: [{
            expand: true
            cwd: 'src/test/fixtures'
            src: ['**/*']
            dest: 'test/fixtures/'
          }]

      bump:
        options:
          commit: true
          commitMessage: 'Release v%VERSION%'
          commitFiles: ['package.json']
          createTag: true
          tagName: 'v%VERSION%'
          tagMessage: 'Version %VERSION%'
          push: false

  # Actually load this plugin's task(s).
  grunt.loadTasks 'tasks'

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-nodeunit'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-bump'

  grunt.registerTask 'test', ['environment:development', 'nodeunit']

  grunt.registerTask 'build', ['clean', 'coffee', 'copy']

  # By default, lint and run all tests.
  grunt.registerTask 'default', ['build', 'test']
