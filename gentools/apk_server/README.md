### APK Server Image 

Requirements:
go / apko / docker

Getting started:
Run init.sh to start up the apk-server. 
<pre>./init.sh</pre>


Here be dragons: Don't use for production. This is a POC only. 

Currently using python http.server to serve up those sweet sweet Melange built APKs to APKO. You will need to populate the folder structure with your signing keys.


I'll likely move this to APKO instance in the future but bootstrapping itself is hard. 



