# start by pulling the python image
FROM python:3.8
# copy the requirements file into the image
COPY . /flask
# switch working directory
WORKDIR /flask
# install the dependencies and packages in the requirements file
RUN pip install -r requirements.txt
# copy every content from the local file to the image
COPY . /flask
EXPOSE 5000
# configure the container to run in an executed manner
ENTRYPOINT ["python"]
CMD ["python", "app.py", "--host=0.0.0.0"]