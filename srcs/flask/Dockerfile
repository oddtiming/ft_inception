        FROM ubuntu

        RUN apt-get update && apt-get install python3  python3-pip -y

        RUN pip install --no-input flask flask-mysql

        COPY . /opt/source-code

        ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask RUN
