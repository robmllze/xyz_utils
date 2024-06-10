# TODO:

A great way to structure a large package is the break it up into smaller independent sub-packages.

For an example, see `shared_src/web_friendly/packages/@location_utils_package`.

Notice how the singleton LocationUtilsPackage is used with extensions to contain all the code related to the package.

Sub-packages should be as independent as possible. They should not depend on each other. This allows for easy testing, re-use, adding and removing.
