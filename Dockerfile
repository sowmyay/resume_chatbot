FROM python:3.11-buster as application

WORKDIR /app

RUN pip3 install --upgrade pip
RUN pip3 install uv

RUN mkdir /home/app
WORKDIR /home/app

COPY requirements.txt ./
RUN uv pip install -r ./requirements.txt --system

COPY resume_chatbot /home/app/resume_chatbot
COPY jupyter.sh /home/app/
COPY .env /home/app/