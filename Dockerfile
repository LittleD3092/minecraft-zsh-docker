FROM ubuntu:22.04

# Specify terminal color
ENV TERM xterm-256color

# Install nvim
RUN apt-get update && apt-get install -y neovim

# Install zsh
RUN apt-get update && apt-get install -y zsh
RUN chsh -s $(which zsh)

# Install oh-my-zsh
RUN apt-get update && apt-get install -y curl
RUN apt-get update && apt-get install -y git
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install p10k
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
COPY dotfiles/.p10k.zsh /root/.p10k.zsh
COPY dotfiles/.zshrc /root/.zshrc

# copy gitstatus binary
COPY cachefile/gitstatus /root/.cache/gitstatus

# Install multiple zsh plugins
# 1. zsh-autosuggestions
# 2. zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc

# Install neofetch
RUN apt-get update && apt-get install -y neofetch

# Install htop
RUN apt-get update && apt-get install -y htop

# Install build-essential
RUN apt-get update && apt-get install -y build-essential

# Install java 17
RUN apt-get update && apt-get install -y openjdk-17-jdk

# Install Minecraft
RUN mkdir -p ~/backups
RUN mkdir -p ~/tools
RUN mkdir -p ~/server
# rcon tool
RUN git clone https://github.com/Tiiffi/mcrcon.git ~/tools/mcrcon
RUN cd ~/tools/mcrcon && make && make install
# auto backup
RUN apt-get update && apt-get install -y zip
COPY scripts/backup.sh /root/backup.sh
RUN chmod +x /root/backup.sh
RUN apt-get update && apt-get install -y cron
RUN crontab -l | { cat; echo "0 0 * * * /root/backup.sh"; } | crontab -

# Copy server files
COPY server/ /root/server

# Install forge
RUN cd /root/server && java -jar /root/server/forge-1.20.2-48.1.0-installer.jar --installServer

# Script for running server
COPY scripts/start-vanilla-server.sh /root/start-vanilla-server.sh
COPY scripts/start-forge-server.sh /root/start-forge-server.sh
RUN chmod +x /root/start-vanilla-server.sh
RUN chmod +x /root/start-forge-server.sh