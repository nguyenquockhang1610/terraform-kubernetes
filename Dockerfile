# Use a base image from Docker Hub
FROM httpd:2.4

# Copy files and directories from the local machine to the image
COPY ./web/ /usr/local/apache2/htdocs/

# Expose both HTTP (80) and HTTPS (443) ports
EXPOSE 80
EXPOSE 443

# Start Apache when the container runs
CMD ["httpd", "-D", "FOREGROUND"]
