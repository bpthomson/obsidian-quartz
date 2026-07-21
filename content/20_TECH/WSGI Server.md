---
created: 2026-07-16T01:02:50+08:00
updated: 2026-07-16T13:59:11+08:00
---
## A server that works between [[Web Server]] and web applications

### WSGI
-  A standard specification that defines how a web server communicates with Python web applications (like **Django** or **Flask**).
- `W`eb `S`erver `G`ateway `I`nterface
- Why Flask needs this ?
	> Flask's dev server isn't production-safe: single-threaded, no auto-restart, no worker management


### So for a WSGI server :
- Server that follows the specification of `WSGI`
- Example : `gunicorn`, `uwsgi`

![[20_TECH-WSGI.webp]]
Receive request from [[web server]]
-> Translate the request to web applications
-> Assign workers to run applications processes
-> Return the result back to WSGI Server
-> Traslate the result back to the web server