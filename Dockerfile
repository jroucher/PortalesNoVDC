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
RUN pip install --upgrade pip

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


# ---------------------------------------------------------
# INSTALL selenium
# ---------------------------------------------------------
RUN pip install selenium

# ---------------------------------------------------------
# INSTALL requirements
# ---------------------------------------------------------
RUN pip install --upgrade setuptools
