import traceback

import requests
from datetime import date
from bs4 import BeautifulSoup
import csv
import concurrent.futures
from datetime import datetime
import time

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36"
}


def get_news():
    print("[조선] 뉴스 목록 가져오는 중...")
    today = date.today()
    formatted_date = str(today).replace("-", "")
    formatted_date = int(formatted_date) - 1
    page = 1
    news_list = []
    while True:
        url = f"https://weekly.chosun.com/news/articleList.html?page={page}&sc_section_code=S1N8"
        rq = requests.get(url, headers=headers)
        soup = BeautifulSoup(rq.text, "html.parser")
        selectedList = soup.select("#section-list ul li")
        for temp in selectedList:
            newsDate = temp.select_one(".replace-date").text

            newsDate = datetime.strptime(newsDate, "%Y.%m.%d %H:%M")

            newsDate = int(newsDate.strftime("%Y%m%d"))

            if newsDate > formatted_date:
                continue
            if formatted_date > newsDate:
                return news_list

            news_list.append(
                {
                    "url": temp.select_one(".titles a")["href"],
                    "title": temp.select_one(".titles a").text,

                }
            )
        page += 1
    return news_list


def get_content(news):
    url = f"https://weekly.chosun.com{news['url']}"
    rq = requests.get(url, headers=headers)
    soup = BeautifulSoup(rq.text, "html.parser")

    newsContent = soup.select_one("#article-view-content-div")

    # ".article_issue.article_issue02" 클래스를 가진 요소 제거
    for element in newsContent.select(".article_issue.article_issue02"):
        element.extract()

    # ".article_footer" 클래스를 가진 요소 제거
    for element in newsContent.select("div"):
        element.extract()

    for element in newsContent.select(".ad-template"):
        element.extract()

    content = newsContent.text.replace("\n", "").replace("\t", "").replace("\r", "").lstrip().rstrip()
    news["content"] = content


def save_to_csv(news_list):
    print("[조선] csv 변환 중...")
    today = date.today()
    formatted_date = str(today).replace("-", "")
    formatted_date = int(formatted_date) - 1
    output_file_name = f"output/sports/ChosunSports{formatted_date}.csv"
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
            print('---------------주간 조선 스포츠 뉴스 기사가 없습니다.--------------')
            return
        print("[조선] 본문 가져오는 중...")
        with concurrent.futures.ThreadPoolExecutor() as executor:
            executor.map(get_content, news_list)
        save_to_csv(news_list)
        end_time = time.time()
        print("[조선] 걸린시간 :", end_time - start_time)
        print("[조선] 가져온 기사 :", len(news_list))
        print('---------------주간 조선 스포츠 뉴스 완료---------------')
    except AttributeError as e:
        traceback.print_exc()