# Use the penultimate version of Debian as the base image
FROM debian:buster

# Update the package lists and install the necessary packages
RUN apt-get update && apt-get install -y nginx gettext-base certbot

# Copy the NGINX configuration file to the container
COPY nginx.conf.template /etc/nginx/nginx.conf.template

# Expose port 443 for incoming connections
EXPOSE 443

# Substitute environment variables in the NGINX configuration file
RUN envsubst '$DOMAIN' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf
RUN cat /etc/nginx/nginx.conf

# Obtain an SSL certificate using certbot
# RUN nginx -g daemon off;
# RUN certbot certonly --non-interactive --agree-tos --renew-by-default \
#     --preferred-challenges http-01 --server https://acme-v02.api.letsencrypt.org/directory \
#     --text --email iyahoui-@student.42quebec.com

# Set the entrypoint command to start NGINX and monitor it for crashes
ENTRYPOINT ["nginx", "-g", "daemon off;"]
