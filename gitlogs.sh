# temp=` git log grails-casperjs --pretty=format:'"%h": {%n  "commit": "%H",%n  "author": {"name": "%an, "email: "<%ae>"},%n  "date": "%ad,%n  "message": "%s"%n}' --max-count=10`
# curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d "${temp}" http://requestb.in/vu1jnbvu


