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

news_list = []


def get_news(tag):
    print("뉴스 목록 가져오는 중...")
    today = date.today()
    formatted_date = str(today).replace("-", "")
    formatted_date = int(formatted_date) - 1
    page = 1
    while True:
        url = f"https://www.joongang.co.kr/{tag}?page={page}"
        rq = requests.get(url, headers=headers)
        soup = BeautifulSoup(rq.text, "html.parser")
        selectedList = soup.select("#story_list li")
        if selectedList == []:
            print("기사가 없습니다.")
            break

        for temp in selectedList:
            newsDate = temp.select_one(".date").text
            newsDate = datetime.strptime(newsDate, "%Y.%m.%d %H:%M")
            newsDate = int(newsDate.strftime("%Y%m%d"))

            if newsDate > formatted_date:
                continue
            if formatted_date > newsDate:
                return

            title = temp.select_one(".headline a").text
            title = title.replace("\n", "").replace("\t", "").replace("\r", "").lstrip().rstrip()
            news_list.append(
                {
                    "title": title,
                    "url": temp.select_one(".headline a")["href"],
                }
            )
        page += 1


def get_content(news):
    rq = requests.get(news["url"], headers=headers)
    soup = BeautifulSoup(rq.text, "html.parser")

    newsContent = soup.select_one("#article_body")

    for element in newsContent.select(".caption"):
        element.extract()

    newsContent = newsContent.select("p")

    content = ""

    for temp in newsContent:
        content += temp.text

    content = content.replace("\n", "").replace("\t", "").lstrip().rstrip()
    news["content"] = content


def save_to_csv(news_list):
    print("csv 변환 중...")
    today = date.today()
    formatted_date = str(today).replace("-", "")
    formatted_date = int(formatted_date) - 1
    output_file_name = f"output/JoongangSportsNews{formatted_date}.csv"
    with open(output_file_name, "w", encoding="utf-8") as output_file:
        csvwriter = csv.writer(output_file, delimiter=";")
        csvwriter.writerow(news_list[0].keys())
        for i in news_list:
            csvwriter.writerow(i.values())

def start():
    start_time = time.time()
    get_news("sports")
    get_news("culture")
    get_news("society")
    print("본문 가져오는 중...")
    with concurrent.futures.ThreadPoolExecutor() as executor:
        executor.map(get_content, news_list)
    save_to_csv(news_list)
    end_time = time.time()
    print("걸린시간 :", end_time - start_time)
    print("가져온 기사 :", news_list.__sizeof__())
    print("완료")
    return news_list
