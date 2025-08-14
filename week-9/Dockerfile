FROM python

RUN pip install flask
RUN pip install psycopg2-binary
WORKDIR /app

COPY main.py /app

CMD flask --app main.py run --host=0.0.0.0
