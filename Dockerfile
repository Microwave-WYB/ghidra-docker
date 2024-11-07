FROM eclipse-temurin:23-jdk

# Install dependencies
RUN apt update && apt install -y wget unzip
RUN useradd -m -U -d /ghidra ghidra

# Download and extract Ghidra
WORKDIR /ghidra
RUN wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.2_build/ghidra_11.2_PUBLIC_20240926.zip -O ghidra.zip \
    && unzip ghidra.zip \
    && rm ghidra.zip \
    && mv ghidra_11.2_PUBLIC/* . \
    && rm -r ghidra_11.2_PUBLIC

# Create a directory to store repositories
RUN mkdir -p /ghidra/repos
RUN chown -R ghidra:ghidra /ghidra

USER ghidra
EXPOSE 13100 13101 13102

# Start Ghidra server
CMD ["/ghidra/server/ghidraSvr", "console"]
