FROM python:2.7.18-alpine

ENV TRIGGER_MODULES = "file \
                       parse \
                       tabbar \
                       display \
                       topbar \
                       oauth \
                       urlhandler \
                       tabs \
                       prefs \
                       media \
                       request \
                       capture \
                       permissions \
                       browsersettings \
                       notification \
                       bolts \
                       barcode \
                       contact \
                       gallery \
                       share \
                       geolocation \
                       httpd \
                       icons \
                       calendar \
                       launchimage \
                       platform \
                       splitscreen \
                       payments \
                       accelerometer \
                       facebook \
                       camera \
                       segmentio \
                       flurry \
                       ua-push \
                       sms \
                       ui \
                       parameters"


RUN apk fix && \
    apk --no-cache --update add git git-lfs less openssh && \
    git lfs install && \
    git clone https://github.com/trigger-corp/libreforge.git /libreforge.git && \
    mkdir module_checkouts && \
    cd module_checkouts && \
    sh -c 'for m in $TRIGGER_MODULES; do \
      echo "Cloning https://github.com/trigger-corp/trigger.io-$m.git" &&  \
      git clone https://github.com/trigger-corp/trigger.io-$m.git trigger.io-$m.git; \
    done'

RUN cd /libreforge.git/generate && \
    git config --global url."https://".insteadOf git:// && \
    pip install -r requirements.txt && \
    python setup.py develop

ENTRYPOINT ["forge-generate"]
CMD ["-h"]

