from fastapi import FastAPI, Request, BackgroundTasks
from fastapi.templating import Jinja2Templates
from starlette.middleware.cors import CORSMiddleware
from apscheduler.schedulers.background import BackgroundScheduler
from datetime import date, timedelta
import os, atexit, asyncio
from crawler import (asyncDongaSportsNewsCrawler,
                     asyncDongaHealthNewsCrawler,
                     asyncChosunSportsNewsCrawler,
                     asyncChosunHealthNewsCrawler,
                     asyncJoongangSportsNewsCrawler,
                     asyncJoongangHealthNewsCrawler,
                     asyncNaverSportsNewsCrawler,
                     asyncNaverHealthNewsCrawler)

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

templates = Jinja2Templates(directory="templates")


@app.get("/")
def index(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})


@app.get("/api/sports")
def sports_crawler(request: Request):
    return templates.TemplateResponse("sports.html", {"request": request})


@app.get("/api/health")
def health_crawler(request: Request):
    return templates.TemplateResponse("health.html", {"request": request})


@app.post("/api/sports")
def sports_crawler():
    start_sports_crawler()


@app.post("/api/health")
def health_crawler():
    start_health_crawler()


def start_sports_crawler():
    asyncChosunSportsNewsCrawler.start()
    asyncDongaSportsNewsCrawler.start()
    asyncJoongangSportsNewsCrawler.start()
    asyncNaverSportsNewsCrawler.start()


def start_health_crawler():
    asyncNaverHealthNewsCrawler.start()
    asyncChosunHealthNewsCrawler.start()
    asyncDongaHealthNewsCrawler.start()
    asyncJoongangHealthNewsCrawler.start()


def delete_old_files():  # 일주일 지난 크롤링 파일 삭제
    output_dir_list = ["output/sports/", "output/health/"]
    today = date.today()
    formatted_date = str(today - timedelta(days=8)).replace("-", "")
    for output_dir in output_dir_list:
        for file_name in os.listdir(output_dir):
            if formatted_date in file_name:
                file_path = os.path.join(output_dir, file_name)
                os.remove(file_path)


scheduler = BackgroundScheduler(timezone='Asia/Seoul')
scheduler.add_job(start_sports_crawler, 'cron', hour=0, minute=1)
scheduler.add_job(start_health_crawler, 'cron', hour=0, minute=1)
scheduler.add_job(delete_old_files, 'cron', hour=0, minute=10)
scheduler.start()


@atexit.register
def shutdown_scheduler():
    scheduler.shutdown()
