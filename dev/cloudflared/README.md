# Cloudflared Tunnel

Cloudflared Tunnels are cool, but it imposes limitations on large file data transfers. While it's nice to be able to close off ports 80 and 443 on my firewall, I decided the cons outweighed the advantages for me.

I would absolutely recommend Cloudflared Tunnels for those in a CGNAT situation or if your ISP blocks ports 80 and 443, but without those restrictions I would not use it.

Quick notes on configuring Cloudflared:

1. Create the tunnel on the Cloudflare Zero Trust console.
2. Start the tunnel container with your `${CLOUDFLARED_TOKEN}`
3. Create a public hostname:
    - Subdomain: `*`
    - Domain: `YOUR_DOMAIN`
    - Service: `HTTPS://traefik`
    - TLS: `*.YOUR_DOMAIN`
4. Remove your old `A` records for your domain from the Cloudflare DNS section
4. Add a DNS entry with the following:
    - Type: `CNAME`
    - Name: `*`
    - Target: `YOUR_TUNNEL_ID.cfargotunnel.com`
5. Block ports `80` and `443` on your router.