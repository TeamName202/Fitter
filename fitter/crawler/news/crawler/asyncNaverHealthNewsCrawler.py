import concurrent.futures
import csv
import time
import traceback
from datetime import date

import requests
from bs4 import BeautifulSoup

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36"
}


def get_news():
    print("[네이버] 뉴스 목록 가져오는 중...")
    today = date.today()
    formatted_date = str(today).replace("-", "")
    formatted_date = int(formatted_date) - 1
    base_url = f"https://news.naver.com/main/list.naver?mode=LS2D&mid=shm&sid1=103&sid2=241&date={formatted_date}&page=999"
    rq = requests.get(base_url, headers=headers)
    soup = BeautifulSoup(rq.text, "html.parser")
    last_page = soup.select_one(".paging strong").text
    news_list = []
    for i in range(1, int(last_page) + 1):
        url = f"https://news.naver.com/main/list.naver?mode=LS2D&mid=shm&sid1=103&sid2=241&date={formatted_date}&page={i}"
        rq = requests.get(url, headers=headers)
        beautiful_soup = BeautifulSoup(rq.text, "html.parser")
        selectedList = beautiful_soup.select(".type06_headline li")
        for news in selectedList:
            news_list.append(
                {
                    "url": news.select_one("dt a")["href"],
                    "title": news.select_one("dt a").text,

                }
            )
        return news_list


def get_content(news):
    url = news['url']
    rq = requests.get(url, headers=headers)
    soup = BeautifulSoup(rq.text, "html.parser")
    newsContent = soup.select_one("#dic_area")

    for element in newsContent.select(".end_photo_org"):
        element.extract()

    content = newsContent.text.replace("\n", "").replace("\t", "").replace("\r", "").lstrip().rstrip()
    news["title"] = soup.select_one("#title_area span").text.strip()
    news["content"] = content


def save_to_csv(news_list):
    print("[네이버] csv 변환 중...")
    today = date.today()
    formatted_date = str(today).replace("-", "")
    formatted_date = int(formatted_date) - 1
    output_file_name = f"output/health/NaverHealthNews{formatted_date}.csv"
    with open(output_file_name, "w", encoding="utf-8") as output_file:
        csvwriter = csv.writer(output_file, delimiter=";")
        csvwriter.writerow(news_list[0].keys())
        for i in news_list:
            csvwriter.writerow(i.values())


def start():
    try:
        start_time = time.time()
        news_list = get_news()
        if not news_list:
            print('---------------네이버 건강 뉴스 기사가 없습니다.--------------')
            return
        print("[네이버] 본문 가져오는 중...")
        with concurrent.futures.ThreadPoolExecutor() as executor:
            executor.map(get_content, news_list)
        save_to_csv(news_list)
        end_time = time.time()
        print("[네이버] 걸린시간 :", end_time - start_time)
        print("[네이버] 가져온 기사 :", len(news_list))
        print('---------------네이버 건강 뉴스 완료---------------')
    except AttributeError as e:
        traceback.print_exc()