---
created: 2026-07-14T23:39:10+08:00
updated: 2026-07-15T00:16:51+08:00
---
## Workflow
#### 1. Get a [[Domain Name]]
- I got `caizz.me` on [namecheap](https://ap.www.namecheap.com), since there is a free one year domain using github student pack.
- Typically the cost for first year is cheap, but the price to renew the domain next year will be significantly higher
#### 2. Add a domain in Cloudflare
- In `Dashboard` -> `Add a domain` -> `Connect a domain`
- Will see two cloudflare's [[Name Server|Name Servers]]
#### 3. Change the Domain's Name Server
- Back to the original [[Domain Name#1. Domain Registry|Domain Registry]](namecheap)
- `Domain List` -> `Domain` -> `NAMESERVERS` -> `Custom DNS`
- Paste the two cloudflare's [[Name Server|Name Servers]] here
#### 4. Clear the residual DNS Record
- In cloudflare, go to your domain -> `DNS` -> `DNS Record`
- Find the residual [[DNS Record]] from the original [[Domain Name#1. Domain Registry|Domain Registry]] and delete them
- Preserve the 5 MX [[DNS Record]] and 1 TXT [[DNS Record]] that were automatically created by Namecheap and imported by Cloudflare.
#### 5. Deploy Static Page
- In cloudflare, `Build` -> `Compute` -> `Workers & Pages` -> `Create Application`
- Look for the tiny text `Looking to deploy Pages? Get started`
![[20_TECH-Cloudflare static page deployment and Point to custom domain.webp|565]]
- `Import an existing Git repository` -> Select the repo
- `Framework preset` -> React (Vite)
- `Root directory (advanced)` -> frontend
- Add `Environment Variables`
#### 6. Customize the domain of the Cloudflare page
- Select the Cloudflare page -> `Custom Domains` -> `Set up a custom domain`
- Connect to your designated domain
- Cloudflare will automatically add a `CNAME` [[DNS Record]] for the domain