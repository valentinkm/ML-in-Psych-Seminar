# Use an official R runtime as a parent image
FROM r-base:latest

# Set the working directory in the container
WORKDIR /usr/src/app

# Install Linux dependencies for R packages and other tools
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    gnupg \
    software-properties-common \
    wget \
    curl

# Install GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update && apt-get install -y gh

# Install Quarto
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v0.1.0/quarto-0.1.0-linux-amd64.deb -O quarto.deb \
    && dpkg -i quarto.deb \
    && rm quarto.deb

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

# Set default command
CMD ["Rscript", "your_script.R"]
