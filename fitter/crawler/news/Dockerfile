FROM python:3.9

WORKDIR /code

WORKDIR /code/output

COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY crawler /code/crawler

COPY main.py /code/

COPY templates /code/templates 

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]