# Use a base image
FROM busybox:1.35

# Set the working directory
WORKDIR /app

# Copy the source code into the container
COPY src/ .

# Replace "localhost" with the provided IP address in socket_js.js
ARG ip
RUN sed -i "s/localhost/$ip/g" /app/js/socket_js.js

# Set the entrypoint
ENTRYPOINT ["busybox"]

# Set the default command
CMD ["httpd", "-f", "-v", "-p", "3000"]
