FROM python:3.9

WORKDIR /code

RUN mkdir /code/output

COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./main.py /code/main.py

COPY ./crawler /code/crawler

COPY ./templates /code/templates

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]