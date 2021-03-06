FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y wget openjdk-7-jre-headless xvfb unzip xvfb

RUN wget --no-check-certificate -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo deb http://dl.google.com/linux/chrome/deb/ stable main >> /etc/apt/sources.list.d/google-chrome.list

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 247510BE
RUN echo deb http://ppa.launchpad.net/ubuntu-mozilla-daily/ppa/ubuntu utopic main >> /etc/apt/sources.list.d/firefox.list

RUN apt-get update
RUN apt-get install -y google-chrome-stable
RUN apt-get install -y firefox

# download chrome driver and selenium server
ADD http://selenium-release.storage.googleapis.com/2.44/selenium-server-standalone-2.44.0.jar /srv/

ADD http://chromedriver.storage.googleapis.com/2.12/chromedriver_linux64.zip /srv/
RUN unzip /srv/chromedriver_linux64.zip -d /srv

ADD ./install /

EXPOSE 4444

CMD ["/usr/local/bin/start-selenium-server.sh"]
