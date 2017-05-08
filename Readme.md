docker-mage
===========

MAGE Docker image, based on official node versions.

Usage
-----

Create a `Dockerfile`:

```Dockerfile
FROM stelcheck/mage
# Alternatively, you can add a Node.js version as a tag
FROM stelcheck/mage:7.10.0
```

On build, this will load your source files and run `npm install`
on your codebase. Alternatively, you may also mount `/mnt/app`
during development and run your commands manually.

License
-------

MIT
