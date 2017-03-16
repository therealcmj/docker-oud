FROM oracle/jdk:8
MAINTAINER Chris Johnson (christopher.johnson@oracle.com)

COPY ofm_oud_generic_11.1.2.3.0_disk1_1of1.zip oud.rsp /var/tmp/installer/
COPY oraInst.loc /u01/

RUN yum -y install glibc.i686 unzip

RUN cd /var/tmp/installer && \
   unzip ofm_oud_generic_11.1.2.3.0_disk1_1of1.zip

# sticking with /u01 to be consistent with exiating WLS docker container style
RUN chmod a+xr /u01 && \
    useradd -b /u01 -m -s /bin/bash oracle && \
    echo oracle:oracle | chpasswd && \
    su -c "/var/tmp/installer/Disk1/runInstaller -jreLoc $JAVA_HOME -ignoreSysPrereqs -novalidation -silent -responseFile /var/tmp/installer/oud.rsp -invPtrLoc /u01/oraInst.loc -waitforcompletion" - oracle && \
    rm -rf /var/tmp/installer

USER oracle

CMD /bin/echo "That isn't how you use this. Sorry."
