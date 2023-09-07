import requests
from datetime import date
import math
from bs4 import BeautifulSoup
import csv
import json

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36"
}


def get_news():
    print("뉴스 목록 가져오는 중...")
    today = date.today()
    formatted_date = str(today).replace("-", "")
    formatted_date = int(formatted_date) - 1
    base_url = f"https://api-gw.sports.naver.com/news/articles/general?section=general&date={formatted_date}&sort=latest&page=1&pageSize=1"
    rq = requests.get(base_url, headers=headers)
    end_page = math.ceil(rq.json()["result"]["totalCount"] / 100)
    news_list = []
    for i in range(1, end_page + 1):
        url = f"https://api-gw.sports.naver.com/news/articles/general?section=general&date={formatted_date}&sort=latest&page={i}&pageSize=100"
        rq = requests.get(url, headers=headers)
        for news in rq.json()["result"]["newsList"]:
            news_list.append(
                {
                    "oid": news["oid"],
                    "aid": news["aid"],
                    "title": news["title"],
                    "subContent": news["subContent"],
                    "thumbnail": news["thumbnail"],
                    "dateTime": news["dateTime"],
                }
            )

    return news_list


def get_content(news):
    url = f"https://n.news.naver.com/sports/general/article/{news['oid']}/{news['aid']}"
    rq = requests.get(url, headers=headers)
    soup = BeautifulSoup(rq.text, "html.parser")
    newsContent = soup.select_one("#dic_area")

    for element in newsContent.select(".nbd_table"):
        element.extract()

    content = newsContent.text.replace("\n", "").replace("\t", "").lstrip().rstrip()
    news["content"] = content


def save_to_csv(news_list):
    print("csv 변환 중...")
    today = date.today()
    formatted_date = str(today).replace("-", "")
    formatted_date = int(formatted_date) - 1
    output_file_name = f"output/NaverSportsGeneral{formatted_date}.csv"
    with open(output_file_name, "w", encoding="utf-8") as output_file:
        csvwriter = csv.writer(output_file)
        csvwriter.writerow(news_list[0].keys())
        for i in news_list:
            csvwriter.writerow(i.values())


# Press the green button in the gutter to run the script.
if __name__ == "__main__":
    news_list = get_news()

    print("본문 가져오는 중...")
    for news in news_list:
        get_content(news)
    save_to_csv(news_list)


def start():
    news_list = get_news()

    print("본문 가져오는 중...")
    for news in news_list:
        get_content(news)
    save_to_csv(news_list)
