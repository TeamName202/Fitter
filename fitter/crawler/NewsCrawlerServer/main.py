from fastapi import FastAPI, Request
from fastapi.templating import Jinja2Templates
from starlette.middleware.cors import CORSMiddleware
import AsyncChosunNewsCrawler
import AsyncJoongangSportsNewsCrawler
import AsyncNaverNewsGeneralCrawler
import AsyncDongaCrawler


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


@app.get("/api/chosun")
def chosun_crawler(request: Request):
    return templates.TemplateResponse("chosun.html", {"request": request})


@app.get("/api/donga")
def chosun_crawler(request: Request):
    return templates.TemplateResponse("donga.html", {"request": request})


@app.get("/api/joongang")
def chosun_crawler(request: Request):
    return templates.TemplateResponse("joongang.html", {"request": request})


@app.get("/api/naver")
def chosun_crawler(request: Request):
    return templates.TemplateResponse("naver.html", {"request": request})


@app.post("/api/chosun")
def chosun_crawler():
    return AsyncChosunNewsCrawler.start()


@app.post("/api/donga")
def donga_crawler():
    return AsyncDongaCrawler.start()


@app.post("/api/naver")
def naver_crawler():
    return AsyncNaverNewsGeneralCrawler.start()


@app.post("/api/joongang")
def joongang_crawler():
    return AsyncJoongangSportsNewsCrawler.start()
