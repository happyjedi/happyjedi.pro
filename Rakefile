task default: %w[dev:watch]

desc "Print the version of Jekyll being used."
task :version do
  jekyll "--version"
end

namespace :dev do
  desc "Run Jekyll with future posts and drafts, then automatically reload when saved."
  task :watch do
    clean
    jekyll "serve --config _config.yml,_config_dev.yml --watch --future --drafts -t"
  end

  desc "Build the Jekyll site using the development configuration."
  task :build do
    clean
    jekyll "build --config _config.yml,_config_dev.yml -t"
  end
end

desc "Build the site with the production configuration."
task :deploy do
  system("JEKYLL_ENV=production bundle exec jekyll build --verbose") or exit!(1)
end

desc "Convert markdown files to PDF"
task :topdf do
  system("bundle exec gimli -f src/about.md -y -s src/_assets/css/master.scss -w '--page-size Letter --header-left \"Victor Vinogradov - Full stack Ruby on Rails developer - Resume\" '") or exit!(1)
end

namespace :assets do
  desc "Rake task that Heroku runs to build static assets by defauly. "
  task :precompile => :deploy
end

def jekyll(args)
  system("bundle exec jekyll #{args}") or exit!(1)
end

def clean
  puts "Cleaning previous builds"
  system("rm -Rf #{$build_dir}") or exit!(1)
end
