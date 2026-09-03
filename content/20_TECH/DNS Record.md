---
created: 2026-07-15T15:14:06+08:00
updated: 2026-07-15T15:26:05+08:00
---
- DNS Records are instructions stored in [[DNS]] that describes a domain.
- Telling how to handle with the input [[Domain Name]](output IPV4? another [[Domain Name]]?)

Type of DNS Record

| Record | Purpose                                   | Example                                                                |
| ------ | ----------------------------------------- | ---------------------------------------------------------------------- |
| A      | Maps to IPV4 address                      | 192.168.1.1                                                            |
| AAAA   | Maps to IPV6 address                      | 2001:0db8:85a3:0000:8a2e:0370:7334                                     |
| CNAME  | Maps to another Domain Name(alias)        | new.com                                                                |
| MX     | Specifies mail servers                    | eforward1.registrar-servers.com                                        |
| TXT    | Stores arbitrary text data                | v=spf1 include:spf.servers                                             |
| NS     | Specifies the authorative [[Name Server]] | - amy.ns.cloudflare.com<br>- bob.ns.cloudflare.com                     |
| SRV    | Specifies a port for specific services    | _xmpp._tcp.example.com. 86400 IN SRV 10 5 5223 server.example.com.<br> |
| PTR    | Reverse DNS lookup                        | 255.2.0.192.in-addr.arpa.  IN  PTR  mail.example.com.<br>              |


> [!Info] Reference
> [DNS records | Learning Center](https://www.cloudflare.com/learning/dns/dns-records/)