---
layout: post
title: Setting up Free Let's Encrypt SSL certificates with CertBot
excerpt: A guide for setting up your server with Nginx to use Free SSL certificates
date: 2017-08-13 23:20:00 +03:00
name: 2017-08-13-setup-free-ssl-certificates
tags: ssl certbot nginx
type: post
author: Victor

published: true
footer_related_posts: false

comments: true
---

In this post I will explain how to setup Free SSL certificates for your server with Nginx.

### Install CertBot

We will use a special service - [CertBot](https://certbot.eff.org/){: target="_blank"}. It automatically enables HTTPS on your website with EFF's Certbot, and deploys [Let's Encrypt](https://letsencrypt.org/){: target="_blank"} certificates. Execute below commands to install certbot:

```
wget https://dl.eff.org/certbot-auto
chmod a+x certbot-auto
```

### Generate and install keys to Nginx

Run below command

```
./path/to/certbot-auto --nginx
```

It will prompt you to choose domains for which to activate a HTTPS:

```
Which names would you like to activate HTTPS for?
--------------------------------
1: example.com
2: www.example.com
--------------------------------
```

You can leave input blank and press Enter to select all shown options. Then it will start keys' generation. After that it will prompt you to automatically change Nginx config files to  apply redirection HTTP traffic to HTTPS. If you want to configure files manually as I did, you can Input num 1 and press Enter.

```
Please choose whether or not to redirect HTTP traffic to HTTPS, removing HTTP access.
-------------------------------------------------------------------------------
1: No redirect - Make no further changes to the webserver configuration.
2: Redirect - Make all requests redirect to secure HTTPS access. Choose this for
new sites, or if you're confident your site works on HTTPS. You can undo this
change by editing your web server's configuration.
-------------------------------------------------------------------------------
Select the appropriate number [1-2] then [enter] (press 'c' to cancel): 1
```

At the final stage you will see the following messages:

```
-------------------------------------------------------------------------------
Your existing certificate has been successfully renewed, and the new certificate
has been installed.

The new certificate covers the following domains: https://example.com and
https://www.example.com

You should test your configuration at:
https://www.ssllabs.com/ssltest/analyze.html?d=example.com
https://www.ssllabs.com/ssltest/analyze.html?d=www.example.com
-------------------------------------------------------------------------------

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/example.com/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/example.com/privkey.pem
   Your cert will expire on 2017-11-11. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot-auto
   again with the "certonly" option. To non-interactively renew *all*
   of your certificates, run "certbot-auto renew"

```

Now we can copy these files to our Nginx `sites-available` folder and restart the Nginx service to apply the changes.

```
sudo cp /etc/letsencrypt/archive/example.com/fullchain.pem /etc/nginx/sites-available/ssl/fullchain.pem
sudo cp /etc/letsencrypt/archive/example.com/privkey.pem /etc/nginx/sites-available/ssl/privkey.pem
service nginx restart
```

This guide doesn't cover the SSL configuration of your application, so you should find this information by yourself.

You can test your SSL configuration for security vulnerability by using this service:
[https://www.ssllabs.com/ssltest/analyze.html?d=www.example.com](https://www.ssllabs.com/ssltest/analyze.html?d=www.example.com){: target="_blank"}

And also you can subscribe to the expiry notifier by this command:
```
./path/to/certbot-auto register --update-registration --email yourname+1@example.com
```
