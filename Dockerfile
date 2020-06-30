#FROM python:slim
FROM python:3.8.3-slim-buster
ADD ./requirements.txt ./requirements.txt
RUN pip install -r requirements.txt
#RUN pip3 install -e .
#CMD ["pytest", "-vv", "-s"]
RUN echo "Success!"
#VOLUME ~/.config/watson/config