FROM jfloff/alpine-python:latest-slim
ADD flask-app.py requirements.txt /
RUN pip install --upgrade pip
RUN python3 -m venv env
CMD ['source', 'env/bin/activate']
RUN pip3 install -r requirements.txt
ENTRYPOINT ["python3"]
CMD ["flask-app.py"]
