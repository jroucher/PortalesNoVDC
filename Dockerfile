FROM artifactory.hi.inet/dcip/minimal:6

EXPOSE 9515:9515

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
