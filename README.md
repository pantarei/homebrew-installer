homebrew-installer
==================

Wrapper for [homebrew](https://github.com/Homebrew/homebrew) installation.

Run this script with:

    /bin/bash <(curl -fsSL https://raw.githubusercontent.com/pantarei/homebrew-installer/master/install.sh)

For cleanup and reinstall:

    rm -rf /usr/local/Cellar /usr/local/.git && brew cleanup && brew prune

License
-------

-   The library is licensed under the [MIT
    License](http://opensource.org/licenses/MIT)
