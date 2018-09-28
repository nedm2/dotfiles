#!/usr/bin/env python3

import os
import errno
import time
import shutil

### Vars ###
srcdir  = os.path.dirname(os.path.realpath(__file__))
homedir = os.path.expanduser("~")
bkupdir = os.path.join(homedir, ".dotfiles_bkup")

def mkdir(dirname):
    try:
        os.makedirs(dirname)
    except OSError as e:
        if e.errno != errno.EEXIST:
            raise

def getInstallList():
    install_list_file = os.path.join(srcdir, "install_list.txt")
    with open(install_list_file, "r") as f:
        install_list = [x.strip('\n') for x in f.readlines() if x.strip('\n')]
    return install_list

def getTimestamp():
    return int(time.time()*1000)

def getBackupFilename(filename):
    return "{}_{}".format(filename, getTimestamp())


### Logic starts here ###

install_list = getInstallList()

for target in install_list:
    src_path    = os.path.join(srcdir, target)
    target_path = os.path.join(homedir, target)

    if os.path.isfile(src_path):
        if os.path.islink(target_path):
            os.unlink(target_path)
        elif os.path.isfile(target_path):
            mkdir(bkupdir)
            bkup_path = os.path.join(bkupdir, getBackupFilename(target))
            print("Archiving {} --> {}".format(target_path, bkup_path))
            shutil.move(target_path, bkup_path)
        print("Linking {} --> {}".format(target_path, src_path))
        os.symlink(src_path, target_path)
    else:
        print("{} does not exist".format(src_path))

