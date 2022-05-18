FROM debian:latest

RUN apt update

# Install arduino
RUN apt install -y curl
RUN curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR=/usr/local/bin sh

# Install nim
RUN apt install -y nim

# Install extra boards
RUN arduino-cli core install --additional-urls https://files.seeedstudio.com/arduino/package_seeeduino_boards_index.json Seeeduino:samd

# Copy over the source files
WORKDIR /root/
COPY build.nims .
COPY nimsrc nimsrc/
COPY csrc csrc/

# Keep the container running
CMD nim build.nims
