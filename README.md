DynamoDB Local Docker Image
===========================

[![Build Status][build badge]][Travis CI job]
[![Docker Stars][stars badge]][Docker Hub page]
[![Docker Pulls][pulls badge]][Docker Hub page]

The last Amazon [DynamoDB Local][] [Docker][] image you'll ever need.


Usage
-----

To print out the DynamoDB Local help text, containing a list of flags and their
descriptions, run:

    $ docker run forty8bit/dynamodb-local

This works through the use of the [ENTRYPOINT][] command; you'll only need to
provide whichever option flags you want in your explicit run command. For
example, to run DynamoDB Local with a shared DB file, giving you the ability to
browse the same DB you're developing against in your code through the included
web UI, run:

    $ docker run -p 8000:8000 forty8bit/dynamodb-local -sharedDb

This should expose the DynamoDB Local web UI at http://localhost:8000/shell. If
you're on Mac OS X or Windows, replace localhost with the IP address of your
Docker VM.


What Makes This Image Special?
------------------------------

While [DynamoDB][] itself has a [releases page][] available, there doesn't seem
to be any easy way to see when an update to DynamoDB Local is available. On top
of this, the current most pulled DynamoDB Local image,
[deangiberson/aws-dynamodb-local][], hasn't been updated in _9 months_, meaning
it's missing some major API changes; this image originally came about because
we were hit with a missing API and didn't want to code against now deprecated
calls. It also weighs in at almost 500MB.

To make sure this doesn't bite us again, this image is set up with a
[Travis CI job][] which checks the _ETag_ header for the currently hosted
DynamoDB Local file (which corresponds to its MD5 checksum), automatically
updating and pushing to this repository if a new version has been uploaded.
This, in turn, kicks off the [Docker Hub automated build][Docker Hub page].

All this is kicked off daily, through the handy [Nightli.es][] service, so it
should never become so far out of date again. All you have to do is run the odd
`docker pull forty8bit/dynamodb-local` and get back to work.


[Docker Hub page]: https://hub.docker.com/r/forty8bit/dynamodb-local
[Docker]: https://www.docker.com/
[DynamoDB Local]: http://docs.aws.amazon.com/pt_br/amazondynamodb/latest/developerguide/Tools.DynamoDBLocal.html
[DynamoDB]: http://aws.amazon.com/dynamodb
[ENTRYPOINT]: http://docs.docker.com/engine/reference/builder/#entrypoint
[Travis CI job]: https://travis-ci.org/forty8bit/dynamodb-local-docker-image
[build badge]: https://travis-ci.org/forty8bit/dynamodb-local-docker-image.svg
[deangiberson/aws-dynamodb-local]: https://hub.docker.com/r/deangiberson/aws-dynamodb-local/
[pulls badge]: https://img.shields.io/docker/pulls/forty8bit/dynamodb-local.svg
[releases page]: https://aws.amazon.com/releasenotes/Amazon-DynamoDB
[stars badge]: https://img.shields.io/docker/stars/forty8bit/dynamodb-local.svg
[Nightli.es]: https://nightli.es/
