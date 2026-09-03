---
created: 2026-07-15T22:57:14+08:00
updated: 2026-07-15T23:05:41+08:00
aliases:
  - iptable
---
## A command-line firewall utility in Linux that controls traffic.
---
#### 1. Checking Iptable
```bash
sudo iptables -L INPUT -n --line-numbers # for incoming packets only (INPUT)
```
> result:![[20_TECH-iptables.webp]]
> - There are 7 rules in this iptable
> - OS filter networks from **top to bottom** (checking for rule 1 first)
> - Rule `1` says : always `ACCEPT` TCP packet(prot=`6` means TCP) from any source (`0.0.0.0/0`) arriving at this VM (dest `0.0.0.0/0` = no destination filter), provided it's port is `443`

#### 2. Modifying IP table
```bash
sudo iptables -I INPUT -p tcp --dport 443 -j ACCEPT
```
- `-I` : **Insert** the rule to the very front
- `INPUT` : This rule is for **input** chain (For incoming packets to this VM)
- `-p tcp` : use **TCP** as **protocol**
- `--dport 443` : the **destination port** is 443 (consensus for HTTPS)
- `-j ACCEPT` : **jump** to the **ACCEPT** target
	> [!Note]
	> Since rule order matters, If a `REJECT` rule comes before your `ACCEPT`, your ACCEPT never fires.
	> Therefore, always use **-I**(Insert at front) instead of **-A**(Append at end) when opening a port

#### 3. Saving IP table
- After reboot, iptable will be restored from `/etc/iptables/rules.v4`
- Live rules (in kernel memory) are NOT automatically saved to that file — you must save manually
- Save by
```bash
sudo apt install -y iptables-persistent # For first time only
sudo netfilter-persistent save
```
- Verify if the file is updated
```bash
ls -la /etc/iptables/rules.v4
```

#### 4. Check what's listening on which port
```bash
sudo ss -tlnp
```
> result :
> ![[20_TECH-iptables-1.webp]]


> [!Reference]
> [IPTables - Linux 的防火牆](https://www.weithenn.org/2009/04/iptables-linux.html)