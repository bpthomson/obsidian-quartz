---
created: 2026-07-14T23:50:43+08:00
updated: 2026-07-15T14:56:37+08:00
aliases: [nameserver, name server, nameservers, name servers, Name Servers]
---
> [!tip] Analogy
> `DNS` is the concept of a `phone book system`, while `Name Servers` are the `physical phone books` themselves.
- The actual servers that perform [[DNS]] resolution.
- As the name implies, they are physical or virtual ==servers==.
- They store data such as **DNS records** (e.g., A, CNAME, TXT).
- There are 4 main types of servers involved in the DNS lookup process:
	1. DNS Resolver (Recursive Resolver)
	2. Root Name Server
	3. TLD (Top-Level Domain) Name Server
	4. Authoritative Name Server

	> [!info] Reference
	> [什麼是 DNS，跟 Name Server 又有什麼關聯？](https://clairechang.tw/2023/06/27/web/dns-and-name-server/)

- Different platforms provide their own Name Servers.
	> [!example] Delegation
	> A domain purchased from Namecheap will default to Namecheap's Name Servers. However, you can change the NS records to **delegate** the DNS management to another platform like Cloudflare.

- Usually, at least two Name Servers are provided for **redundancy**. If one fails, the other can still respond to queries.
	> [!example] Cloudflare
	> In Cloudflare, they typically look like `amy.ns.cloudflare.com` and `bob.ns.cloudflare.com`.

