---
created: 2026-07-16T14:50:57+08:00
updated: 2026-07-16T23:50:31+08:00
---
## An intermediary that acts on behalf of the backend servers, hiding their identities.

![[20_TECH-Reverse Proxy-1.webp]]
#### Advantages
- `Prevent cyberattacks` : Backend IP is not visible on the Internet
- `Load balance` : Distribute requests evenly across each backend server
- `Cache` : Cache the contents
- `Security` : Terminate [[TLS]] here to establish a secure HTTPS connection

Also see [[Forward Proxy]]
> [!Reference]
> [What is a reverse proxy? | Proxy servers explained](https://www.cloudflare.com/learning/cdn/glossary/reverse-proxy/)