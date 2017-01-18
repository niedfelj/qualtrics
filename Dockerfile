FROM code.osu.edu:5000/asctech/ruby:2.3

ENV GEM_HOME=/usr/local/bundle
ENV PATH=$GEM_HOME/bin:$PATH

RUN echo "gem: --no-ri --no-rdoc" >> ~/.gemrc \
  && bundle config --global jobs 3

WORKDIR /app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY qualtrics.gemspec qualtrics.gemspec
COPY ./lib/qualtrics/version.rb /app/lib/qualtrics/version.rb
RUN bundle install

COPY . /app

CMD /bin/bash
