[![Build Status](https://travis-ci.org/proddi/esdoc.svg?branch=master)](https://travis-ci.org/proddi/esdoc)
[![Code Coverage](https://codecov.io/gh/proddi/esdoc/branch/master/graph/badge.svg)](https://codecov.io/gh/proddi/esdoc)


# Fork information

This repo is a fork of https://github.com/esdoc/esdoc.

The main feature add is providing a Plugin-hook to extend/change ast-parsing for various doc types.

Example:

    class Plugin {
      onHandleDocClass(ev) {
        const {type, Clazz, ParamParser} = ev.data;
        if (ev.data.type === 'Class') {
          ev.data.Clazz = class extends ev.data.Clazz {

            /**
             * change the parsing of @emits from:
             *   @emits <identifier> [description]
             * to:
             *   @emits <type> <name> [-] [description]
             */
            _$emits() {
              const values = this._findAllTagValues(['@emits']);
              if (!values) return;

              this._value.emits = [];
              for (const value of values) {
                const {typeText, paramName, paramDesc} = ParamParser.parseParamValue(value);
                const result = ParamParser.parseParam(typeText, paramName, paramDesc);
                this._value.emits.push(result);
              }
            }

          }
        }
      }
    }


Installation

    npm install --save-dev @proddi/esdoc


# (original) ESDoc

ESDoc is a documentation generator for JavaScript.<br/>
Please <a href="https://try.esdoc.org">try it out</a>!

<img class="screen-shot" src="https://raw.githubusercontent.com/esdoc/esdoc/master/manual/asset/image/top.png" width="500px" style="max-width: 500px; border: 1px solid rgba(0,0,0,0.1); box-shadow: 1px 1px 1px rgba(0,0,0,0.5);">

# Features
- Generates good documentation.
- Measures documentation coverage.
- Integrate test codes into documentation.
- Integrate manual into documentation.
- Parse ECMAScript proposals.
- [ESDoc Hosting Service](https://doc.esdoc.org)

# Users
- [ESDoc](https://doc.esdoc.org/github.com/esdoc/esdoc/) (self-hosting &#x1F604;)
- [RxJS](http://reactivex.io/rxjs/)
- [Sketch API](http://developer.sketchapp.com/reference/api/)

And [more](https://github.com/search?o=desc&q=esdoc+filename%3Apackage.json+-user%3Ah13i32maru+-user%3Aesdoc+-user%3Aes-doc&ref=searchresults&s=indexed&type=Code&utf8=%E2%9C%93).

# Quick Start
```sh
# Move to a your project directory.
cd your-project/

# Install ESDoc and standard plugin.
npm install --save-dev esdoc esdoc-standard-plugin

# Create a configuration file.
echo '{
  "source": "./src",
  "destination": "./docs",
  "plugins": [{"name": "esdoc-standard-plugin"}]
}' > .esdoc.json

# Run ESDoc.
./node_modules/.bin/esdoc

# View a documentation
open ./docs/index.html
```

# Document
please visit [esdoc.org](https://esdoc.org) to see more documentation.

# License
MIT

# Author
[Ryo Maruyama@h13i32maru](https://twitter.com/h13i32maru)
