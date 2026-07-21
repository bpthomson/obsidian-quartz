---
created: 2026-07-15T17:13:34+08:00
updated: 2026-07-17T15:46:48+08:00
---
![[Drawing 2026-07-16 21.37.03.excalidraw|100%]]
## 0. Preliminary Work
#### 0.1 Check path and variables
- `Public IP Address`: 161.118.232.242
- `Backend Domain`: api.caizz.me
- `project path`: /home/ubuntu/test
- `virtual env path`: /home/ubuntu/test/.venv
- `python enter point`: app:app
#### 0.2 Install system packages
```bash
sudo apt update
sudo apt install nginx certbot python3-certbot-nginx -y
```
#### 0.3 Create [[DNS Record]] on cloudflare
- In cloudflare
- `Select the domain` -> `DNS records` -> `Add record`
- Add a `A record` to bind the VM public IP, temporarily disable cloudflare [[Forward Proxy|proxy]] for now ([[DNS]] only)
	![[20_TECH-Backend Deployment Cheat Sheet.webp|416]]
## 1. Network and Firewall

#### 1.1 Oracle Cloud Network Security
- The **outer gate**: filters traffic at Oracle's network before it reaches your VM
- In Oracle Cloud console
- `Instance` -> `Subnet` -> `Security List` -> `Add Ingress Rule`
- Add port 80 for HTTP connection (TCP, 0.0.0.0/0)
- Add port 443 for HTTPS connection (TCP, 0.0.0.0/0)
- see [TCP/UDP埠列表](https://zh.wikipedia.org/zh-tw/TCP/UDP%E7%AB%AF%E5%8F%A3%E5%88%97%E8%A1%A8)

#### 1.2 Ubuntu internal Firewall
- The **inner gate**: filters traffic inside the VM before it reaches your service
- Firewall at OS layer (inside VM)
- In VM terminal
```bash
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT # Open Port 80
sudo iptables -I INPUT -p tcp --dport 443 -j ACCEPT # Open Port 443
```
- See [[iptables]]

## 2. Gunicorn Setup
- A kind of [[WSGI Server]], working between `web server` and `web application`
#### 2.1 For Testing and One-Off execution
```bash
cd /home/ubuntu/test
source .venv/bin/activate
uv pip install gunicorn
gunicorn -w 3 -b 0.0.0.0:5000 app:app 
```
- `-w 3` : Assign `3` workers
- `-b 0.0.0.0:5000` : Bind port `5000` on all network interfaces
- `app:app` : Module `app.py` with the WSGI callable named `app`
#### 2.2 To Become a Background process running non-stop
- Use ==Systemd==
- The services (systemd unit file) should be put under `/etc/systemd/system/`
```bash
sudo nano /etc/systemd/system/api.service
```
- Paste below settings
```toml
[Unit]
Description=Gunicorn instance to serve Caizz API
After=network.target

[Service]
User=ubuntu
Group=ubuntu
WorkingDirectory=/home/ubuntu/test
Environment="PATH=/home/ubuntu/test/.venv/bin"
ExecStart=/home/ubuntu/test/.venv/bin/gunicorn -w 3 -b 127.0.0.1:5000 app:app
Restart=always

[Install]
WantedBy=multi-user.target
```
- `After` : Tell the process to run after the network is connected
- `User` : Run gunicorn as the Linux user, instead of root
- `Environment` : which gunicorn
- `WantedBy` : whenever the system reaches `multi-user.target` during boot, starts gunicorn.service.
> Note that binding `127.0.0.1`(localhost) instead of `0.0.0.0`, since we are only accepting connections from `nginx` (arrive through localhost)
```bash
sudo systemctl daemon-reload # Reload all service definitions
sudo systemctl start api # Start api.service
sudo systemctl enable api # Whenever the computer boots, automatically start this service.
sudo systemctl status api # Shows current status
```
> Note that for only modifying backend files, not api.service itself, just restart with a sinlge line command :
```bash
sudo systemctl restart api
```
## 3. Nginx Setup
- An open-source [[Web Server]], that acts as a [[Reverse Proxy]] to protect backend
- The setup file should be put under `etc/nginx/sites-available/`
```bash
sudo nano /etc/nginx/sites-available/api
```
- Paste below settings
```nginx
server {
    listen 80;
    server_name api.caizz.me;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```
- `listen 80` : Listen for incoming HTTP connection on port 80
- `server_name` : Tell Nginx to use this server block if the requested domain is at `api.caizz.me`
- `proxy_pass` : Forward this request to backend server (gunicorn) running at `127.0.0.1:5000`
- `proxy_set_header` : Request headers
> We dont have to manullay write `listen 443` in this configuration file, the `certbot` in next step will automatically modify this file to redirect HTTP connection to HTTPS.
```bash
sudo ln -s /etc/nginx/sites-available/api /etc/nginx/sites-enabled/ # Create a symbolic link (shortcut) in enabled folder
sudo nginx -t # Test the configuration to see if there are errors
sudo systemctl restart nginx # Restart
```

> [!warning] Nginx Multi-App Routing & The Trailing Slash Trap 
> - Note that when mapping multiple API paths on different ports, specify dedicated `location` blocks for each route:
> - Notice the ending `/` on the `proxy_pass` URL. Adding a trailing slash after the port tells Nginx to **discard the location prefix** before forwarding the request to your backend.
> 

| proxy_pass               | Upstream Forwarded Request         | Explanation                 |
| ------------------------ | ---------------------------------- | --------------------------- |
| `http://127.0.0.1:5002/` | `http://127.0.0.1:5002/api/ls`     | `app.route('/api/ls')`      |
| `http://127.0.0.1:5002`  | `http://127.0.0.1:5002/mbl/api/ls` | `@app.route('/mbl/api/ls')` |

```nginx
server {
    server_name api.caizz.me;

    location /mad/ {
        proxy_pass http://127.0.0.1:5001/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    location /mbl/ {
        proxy_pass http://127.0.0.1:5002/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    ...
}
```
## 4. Certbot Setup
- ==Certbot== : An open-source software tool to obtain and install [[TLS]] certificate, enabling HTTPS connection.
- **Check the [[DNS Record]] of the domain is `DNS Only`**
- Apply and install the certificate
```bash
sudo certbot --nginx -d api.caizz.me
sudo certbot renew --dry-run # Testing auto renew the certificate
```
- **Turn on cloudflare proxy for the domain on the [[DNS Record]]**
- `SSL/TLS` -> `Overview` -> `Configure` -> Set encrypt mode to `Full (Strict)`