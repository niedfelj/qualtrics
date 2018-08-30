FROM code.osu.edu:5000/asctech/docker/ruby:2.3

ENV GEM_HOME=/usr/local/bundle
ENV PATH=$GEM_HOME/bin:$PATH

RUN useradd --user-group qualtrics && \
  chown -R qualtrics:qualtrics $GEM_HOME

USER qualtrics
WORKDIR /app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY qualtrics.gemspec qualtrics.gemspec
COPY ./lib/qualtrics/version.rb /app/lib/qualtrics/version.rb
RUN bundle install

COPY . /app

CMD /bin/bash
