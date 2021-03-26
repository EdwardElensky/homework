FROM frolvlad/alpine-python3
ADD flask-app.py requirements.txt /
RUN pip3 install -r requirements.txt
ENTRYPOINT ["python3"]
CMD ["flask-app.py"]
