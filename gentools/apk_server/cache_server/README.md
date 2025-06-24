# APK Proxy cache example


This software is known to the State of California to cause bugs, unexpected behavior, loss of productivity, mild developer frustration, and occasional existential dread. Use with caution.

<pre>
docker-compose up
</pre>


<pre>
apko build example.yaml localhostversion:latest localhostversion.tar --sbom=false
</pre>

Set your contents up like this for using local nginx cache server:

<pre>
contents:
  keyring:
    - http://localhost:8080/wolfi-signing.rsa.pub
  repositories:
    - http://localhost:8080/
</pre>
