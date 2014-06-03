expect = require 'expect.js'

simpleGit  = require('../lib/simple-git')
Repository = require('../lib/repository')
CliOption  = require('../lib/cli-option')

describe 'Repository', ->
  describe 'constructor', ->
    it 'should throw error on wrong path', ->
      fn = -> new Repository('/wrong/path')
      expect(fn).to.throwException (e) ->
        expect(e).to.be.a simpleGit.BadRepositoryError

    it 'should set the path', ->
      path = '/path/to/.git'
      repository = new Repository(path)
      expect(repository.path).to.be path

  describe 'workingDir', ->
    it 'should return the repository working directory', ->
      repository = new Repository('/path/to/.git')
      expect(repository.workingDir()).to.be '/path/to'

  describe 'clone', ->
    it 'should clone repository to given directory', (done) ->
      Repository.clone 'https://github.com/tuvistavie/node-simple-git', '/tmp/node-simple-git', {
        onError: (error) ->
          expect(error).to.not.be null
          done()
        onSuccess: (repository) ->
          done()
      }