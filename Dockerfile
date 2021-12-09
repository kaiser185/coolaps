#CREDIT TO Salvador Abreu for the initial version of this dockerfile
FROM debian:stable-slim

ENV WORKDIR=/root
WORKDIR ${WORKDIR}
#This environment variable controls where your persistent storage volume will be mounted, so make sure that if you want to mount a local volume on to your container that you point it to this folder, i.e. /root/data
ENV SAVEDIR=${WORKDIR}/data

ENV LOGTALKHOME=/usr/share/logtalk
ENV LOGTALKUSER=${WORKDIR}/logtalk
ENV PATH=\
$PATH:\
${SAVEDIR}:\
${SAVEDIR}.init:\
${LOGTALKHOME}/tools/diagrams:\
${LOGTALKHOME}/tools/lgtdoc/xml:\
${LOGTALKHOME}/scripts:${LOGTALKHOME}/integration:

ENV MANPATH=${MANPATH}:${LOGTALKHOME}/man

ENV LGTVERS=3.51.0-1
ENV LGTDEB=logtalk_${LGTVERS}_all.deb

RUN apt-get update \
&& apt-get upgrade -y \
&& apt-get install -y --no-install-recommends swi-prolog-nox \
&& apt-get install -y wget

RUN [ -e ${WORKDIR}/${LGTDEB} ] || wget -q https://logtalk.org/files/${LGTDEB} 
RUN dpkg -i ${WORKDIR}/${LGTDEB}
RUN rm -f ${WORKDIR}/${LGTDEB}

RUN logtalk_user_setup

RUN useradd -ms /bin/bash logtalk

COPY ./init.pl ${WORKDIR}/.config/swi-prolog/
COPY ./settings.lgt ${LOGTALKUSER}/

## Note, this dockerfile is configured to run the server daemon instead of 
## having an interactive shell by default. To change this, 
## comment out all the following lines EXCEPT for the COPY command
## Also note, if you change the application source folder, you must change the
## following line, otherwise you code will not be copied to the image.
COPY sample-src/ ${WORKDIR}/
RUN touch httpd.log
RUN chown logtalk:logtalk ${WORKDIR}/httpd.log
RUN chown logtalk:logtalk ${WORKDIR}/.lgt_tmp
RUN chown logtalk:logtalk ${WORKDIR}/logtalk
CMD ["swilgt", "/root/run.lgt"]


