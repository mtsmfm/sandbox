This repository's files created by `middleman init . --rack` except Gemfile*.

    BUNDLE_GEMFILE=Gemfile-mm338 bundle install
    BUNDLE_GEMFILE=Gemfile-mmv3stable bundle install

    BUNDLE_GEMFILE=Gemfile-mm338 bundle exec rackup      # work
    BUNDLE_GEMFILE=Gemfile-mmv3stable bundle exec rackup # doesn't work
