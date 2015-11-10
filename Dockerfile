FROM java:jre

# Expose the default DynamoDB Local port; don't use -port flag in run.
EXPOSE 8000

WORKDIR /opt/dynamodb-local/

# Run command should consist solely of configuration flags; default to printing
# help info.
ENTRYPOINT ["java", "-Djava.library.path=./DynamoDBLocal_lib", "-jar", \
    "DynamoDBLocal.jar"]
CMD ["-help"]

# Should match MD5 checksum of latest DynamoDB Local release (.tar.gz variant).
# Changing this triggers layer cache invalidation.
ENV CHECKSUM none

RUN curl -#L \
    dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest \
    | tar xz
