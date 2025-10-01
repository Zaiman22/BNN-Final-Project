FROM quay.io/jupyter/pytorch-notebook:cuda12-python-3.11.8

# Switch to root
USER root

# Install base tools
RUN apt-get update && apt-get install -y \
    git python3-pip \
    && rm -rf /var/lib/apt/lists/*
    
# # copy entrypoint scriot
# COPY ./entry.sh /usr/local/bin/entry.sh
# RUN chmod +x /usr/local/bin/entry.sh
# Switch back to jovyan (default notebook user)
USER $NB_UID

# Upgrade pip for user environment
RUN pip install --upgrade pip setuptools wheel

# Install required Python packages
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt



# ENTRYPOINT ["/usr/local/bin/entry.sh"]
