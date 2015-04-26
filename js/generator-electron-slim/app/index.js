'use strict';
var yeoman = require('yeoman-generator');
var chalk = require('chalk');
var yosay = require('yosay');

module.exports = yeoman.generators.Base.extend({
  initializing: function () {
    this.pkg = require('../package.json');
  },

  prompting: function () {
    var done = this.async();

    // Have Yeoman greet the user.
    this.log(yosay(
      'Welcome to the polished ' + chalk.red('ElectronSlim') + ' generator!'
    ));

    var prompts = [{
      type: 'confirm',
      name: 'someOption',
      message: 'Would you like to enable this option?',
      default: true
    }];

    this.prompt(prompts, function (props) {
      this.props = props;
      // To access props later use this.props.someOption;

      done();
    }.bind(this));
  },

  writing: {
    gulpfile: function () {
      this.fs.copy(
        this.templatePath('gulpfile.coffee'),
        this.destinationPath('gulpfile.coffee')
      );
    },

    app: function () {
      this.fs.copy(
        this.templatePath('src/**/*'),
        this.destinationPath('src')
      );
      this.fs.copy(
        this.templatePath('_package.json'),
        this.destinationPath('package.json')
      );
      this.fs.copy(
        this.templatePath('_Gemfile'),
        this.destinationPath('Gemfile')
      );
    },

    projectfiles: function () {
      this.fs.copy(
        this.templatePath('editorconfig'),
        this.destinationPath('.editorconfig')
      );
      this.fs.copy(
        this.templatePath('jshintrc'),
        this.destinationPath('.jshintrc')
      );
    }
  },

  install: function () {
    this.npmInstall(
      [
        'coffee-script',
        'gulp',
        'gulp-util',
        'gulp-coffee',
        'gulp-sass',
        'gulp-slim',
        'gulp-plumber',
        'electron-prebuilt'
      ],
      {'saveDev': true}
    );
    this.installDependencies();
    this.spawnCommand('bundle', ['install', '--binstubs']);
  }
});
