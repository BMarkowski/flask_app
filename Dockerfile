FROM jenkins/jenkins:lts-jdk11
USER root
RUN apt update && \
apt -y install apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; 
echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
    $(lsb_release -cs) \
    stable" && \
apt-get update && \
apt-get -y install docker-ce
RUN apt-get install -y docker-ce
RUN usermod -a -G docker jenkins
USER jenkins
#FROM python:3.9-slim-buster
#RUN mkdir /usr/src/app/
#COPY . /usr/src/app/
#WORKDIR /usr/src/app/
#EXPOSE 5555
#RUN pip install -r requirements.txt
#CMD ["python", "aplikacja.py"]