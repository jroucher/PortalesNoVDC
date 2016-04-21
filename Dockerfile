FROM artifactory.hi.inet/dcip/minimal:7

EXPOSE 9515:9515
# ---------------------------------------------------------
# Install packages needed to work
# First iteration
# ---------------------------------------------------------
RUN yum install -y \
    createrepo rpmdevtools make gcc redhat-rpm-config \
    tar wget which \
    docker python-docker-py \
    && yum clean all

# ---------------------------------------------------------
# Second iteration - npm & python needed downgrades
# ---------------------------------------------------------
RUN yum downgrade -y openssl-libs-1.0.1e-42.el7 krb5-libs-1.12.2-14.el7 \
    python-2.7.5-16.el7 python-libs-2.7.5-16.el7 \
    && yum install -y npm python-pip python-virtualenv python-isodate python-xmltodict ansible \
    && yum clean all

# ---------------------------------------------------------
# Install npm stuff
# ---------------------------------------------------------
RUN npm config set registry http://artifactory.hi.inet/npm \
    && npm install -g bower grunt-cli \
    && npm cache clean

# ---------------------------------------------------------
## CONFIGURE
# ---------------------------------------------------------
# Add sonar conf to access central
#COPY sonar-runner.properties /opt/ss/develenv/platform/sonar-runner/conf/sonar-runner.properties
# Run some configs
RUN mkdir -p /etc/docker/certs.d/artifactory.hi.inet \
    && cp /home/contint/CATID.cer /etc/docker/certs.d/artifactory.hi.inet/ca.crt \
    && su - contint -c "npm config set registry http://artifactory.hi.inet/npm" \

# ---------------------------------------------------------
# Install xvfb and firefox, needed to run tests in browsers
# ---------------------------------------------------------
RUN yum install -y xorg-x11-server-Xvfb-1.15.0-32.el7 gdk-pixbuf2 firefox


# ---------------------------------------------------------
# Fix problem with D-Bus that prevents Firefox from starting
# ---------------------------------------------------------
RUN chmod a+w /etc/machine-id
RUN dbus-uuidgen > /etc/machine-id
RUN chmod a-w /etc/machine-id

# ---------------------------------------------------------
# INSTALL pip
# ---------------------------------------------------------
RUN easy_install pip

# ---------------------------------------------------------
# INSTALL virtualEnv
# ---------------------------------------------------------
RUN pip install virtualenv

# ---------------------------------------------------------
# INSTALL behave
# ---------------------------------------------------------
RUN easy_install behave

# ---------------------------------------------------------
# CREATING & ACTIVATE venv
# ---------------------------------------------------------
RUN virtualenv venv
RUN source venv/bin/activate

# ---------------------------------------------------------
# INSTALL selenium
# ---------------------------------------------------------
RUN pip install selenium

# ---------------------------------------------------------
# INSTALL requirements
# ---------------------------------------------------------
RUN pip install --upgrade setuptools
RUN pip install -r requirements.txt

# ---------------------------------------------------------
# DOWNLOAD
# ---------------------------------------------------------
RUN wget https://github.com/jgraham/wires/releases/download/v0.6.2/wires-0.6.2-linux64.gz
