# Use httpd as the base image
FROM httpd:2.4

# Install necessary packages
RUN apt-get update && \
    apt-get install -y python3-pip && \
    pip3 install mkdocs

# Copy your MkDocs documentation files into the container
COPY ./sosotech-docs/ /usr/local/apache2/htdocs/

# Expose port 80 for serving the documentation
EXPOSE 80
