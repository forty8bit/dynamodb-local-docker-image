DynamoDB Local Docker Image
===========================

[DynamoDB Local][1] Docker image for development. 


Requirements
------------

[Docker][2] and a working internet connection.


Running
-------

To print out the DynamoDB Local help text, containing a list of flags
and their descriptions, run:

    $ docker run forty8bit/dynamodb-local

To run DynamoDB Local with a shared DB file, for the ability to browse the DB
through the included web UI, run:

    $ docker run -p 8000:8000 forty8bit/dynamodb-local -sharedDb

This should expose the DynamoDB Local web UI at http://localhost:8000/shell. If
you're on Mac OS X or Windows, replace localhost with the IP address of your
Docker VM.

[1]: http://docs.aws.amazon.com/pt_br/amazondynamodb/latest/developerguide/Tools.DynamoDBLocal.html
[2]: http://www.docker.com
