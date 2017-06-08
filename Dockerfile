FROM centos:6

RUN /bin/cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN yum update -y; \
  yum groupinstall -y "Development tools"

RUN yum -y install openssl openssl-devel readline-devel readline compat-readline5 libxml2-devel libxslt-devel libyaml-devel git vim emacs rsync autoconf automake gcc patch patchutils unzip libjpeg-turbo-devel libpng-devel giflib-devel sqlite-devel postgresql95-devel libjpeg-devel libpng-devel mysql-devel ImageMagick ImageMagick-devel;

#rbenv
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN mkdir -p ~/.rbenv/plugins
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN echo -e 'export PATH=~/.rbenv/bin:$PATH\neval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

#ruby
ENV CONFIGURE_OPTS --disable-install-doc
RUN ~/.rbenv/plugins/ruby-build/bin/ruby-build 2.3.1 ~/.rbenv/versions/2.3.1

#bundler
RUN echo "install: --no-document" >> /.gemrc; echo "update: --no-document" >> /.gemrc
ENV PATH /root/.rbenv/shims:/root/.rbenv/bin:$PATH
RUN eval "$(rbenv init -)"; rbenv global 2.3.1; gem install bundler;

ENV TMPDIR /tmp
WORKDIR $TMPDIR

ADD Gemfile $TMPDIR/Gemfile
ADD Gemfile.lock $TMPDIR/Gemfile.lock

ENV BUNDLE_HOME /var/bundle
RUN mkdir $BUNDLE_HOME
RUN bundle install --path $BUNDLE_HOME --jobs=3

ENV APP_HOME /drops
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME
RUN bundle install
