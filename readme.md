# happyjedi.pro Source

This is the source code for my personal website, [happyjedi.pro](http://www.happyjedi.pro)

## Usage

Setting up and using the site is pretty easy. Make sure you have Ruby installed, and the bundler gem, then install the required gems.

```bash
gem install bundler
bundle install
```

Then run using rake : `bundle exec rake dev:watch`
OR : bundle exec puma -t 8:32 -w 3 -p 3000

Then simply go to [localhost:4000][localhost] in your browser.

### Rake Tasks

Other rake tasks are:
* `version` - Jekyll version number.
* `dev:watch` - Start the Jekyll server in watch mode with future and draft posts. Loads the `_config_dev.yml` file to override production values with development values.
* `dev:build` - Builds the site with the default options. Loads the `_config_dev.yml` file to override production values with development values.
* `deploy` - Do a production build.
* `typekit:add_domain` - Adds a domain to a typekit kit whitelist based on your environment.
* `typekit:remove_domain` - Removes a domain from a typekit kit whitelist based on your environment.
* `assets:precompile` - Default task called by the build pipeline. See below for details.

### Deployment

Deployment is completely automated, and happens via a [Heroku pipeline][heroku_pipeline]. Anything that goes to the `master` branch is automatically deployed to staging. I use [Heroku Review Apps][heroku_review] to automatically stage branches to help with gaining feedback from friends, family, and colleagues.

The [Heroku Ruby Buildpack][heroku_buildpack] automatically runs the Rake task `assets:precompile`, so to minimise my personal technical debt I utilise this default behaviour to build the site.

## Licensing

The content and design have been bundled into one license and the code has been bundled into a second. Check below for details.

### The Content and Design

The content and design are licensed under [CC BY-NC-SA 3.0](http://creativecommons.org/licenses/by-nc-sa/3.0/ "Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License"). Essentially, this allows you to share content and to adapt (or build upon) my works, but not for commercial purposes and only if you share attribution and under the same license agreement.

### The Code

The code is licensed under [MIT](http://opensource.org/licenses/MIT "MIT License Agreement"), therefore the following applies:

Copyright (c) 2020 Victor Vinogradov / HappyJedi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[happyjedi.pro]: http://happyjedi.pro
[localhost]: http://localhost:4000
[heroku_review]:  https://devcenter.heroku.com/articles/github-integration-review-apps
[heroku_buildpack]: https://github.com/heroku/heroku-buildpack-ruby
[heroku_postdeploy]: https://devcenter.heroku.com/articles/github-integration-review-apps#the-postdeploy-script
[heroku_predestroy]: https://devcenter.heroku.com/articles/github-integration-review-apps#pr-predestroy-script
[heroku_pipeline]: https://devcenter.heroku.com/articles/pipelines
[typekit_api_key]: https://typekit.com/account/tokens