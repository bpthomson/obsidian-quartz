---
created: 2026-07-16T15:12:58+08:00
updated: 2026-07-16T15:13:34+08:00
aliases:
  - SSL
---
## A protocol that ensures confidentiality and integrity for communications between two devices

- `T`ransport `L`ayer `S`ecurity
- 3 main functions
	1. Encrypt transmitted data
	2. Ensure the identity of both sides are what they claim to be
	3. Verify that data has not been forged or tampered with
- `SSL` is the obsolete protocol (unsafe), but people still use the two terms interchangeably
- For a `HTTPS` connection, the server presents a certificate to prove its identity, as required by TLS. And this is what makes the difference between `HTTP` and `HTTPS`

> [!Reference]
> [What is TLS (Transport Layer Security)?](https://www.cloudflare.com/learning/ssl/transport-layer-security-tls/)