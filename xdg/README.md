xdg-utils
=========

# determine a file's MIME type
$ xdg-mime query filetype photo.jpeg
image/jpeg

# determine the default application for a MIME type
$ xdg-mime query default image/jpeg
gimp.desktop

# change the default application for a MIME type
$ xdg-mime default feh.desktop image/jpeg

# open a file with its default application
$ xdg-open photo.jpeg

# shortcut to open all web MIME types with a single application
$ xdg-settings set default-web-browser firefox.desktop

# shortcut for setting the default application for a URL scheme
$ xdg-settings set default-url-scheme-handler irc xchat.desktop

perl-file-mimeinfo
==================

# determine a file's MIME type
$ mimetype photo.jpeg
photo.jpeg: image/jpeg

# choose the default application for this file
$ mimeopen -d photo.jpeg
Please choose an application

    1) Feh (feh)
    2) GNU Image Manipulation Program (gimp)
    3) Pinta (pinta)

use application #

# open a file with its default application
$ mimeopen -n photo.jpeg

