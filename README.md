homebrew-installer
==================

Wrapper for [homebrew](https://github.com/Homebrew/homebrew) installation.

Run this script with:

    $ git clone https://github.com/pantarei/homebrew-installer.git /tmp/homebrew-installer
    $ cd /tmp/homebrew-installer
    $ ./install.sh

For cleanup before reinstall:

    rm -rf /usr/local/Cellar /usr/local/.git && brew cleanup && brew prune

License
-------

-   The library is licensed under the [MIT
    License](http://opensource.org/licenses/MIT)

