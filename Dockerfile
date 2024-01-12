# Use an official R runtime as a parent image
FROM r-base:latest

# Set the working directory in the container
WORKDIR /usr/src/app

# Install Linux dependencies for R packages (if any)
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev

# Install R packages
RUN Rscript -e "install.packages('rmarkdown')" \
    && Rscript -e "install.packages('ctsem')" \
    && Rscript -e "install.packages('ctsemOMX')"

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["Rscript", "your_script.R"]
