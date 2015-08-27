#!/usb/bin/python
from subprocess import Popen, PIPE


def get_password(name):
    """ Returns password, retrieved from gnome keyring """
    cmd = ["gnome-keyring-query", "get", name]
    stdout, stderr = Popen(cmd, stdout=PIPE).communicate()
    return stdout.strip()
