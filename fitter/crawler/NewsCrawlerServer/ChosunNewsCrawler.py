import requests
from datetime import date, datetime
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
    page = 1
    news_list = []
    while True:
        url = f"https://weekly.chosun.com/news/articleList.html?page={page}"
        rq = requests.get(url, headers=headers)
        soup = BeautifulSoup(rq.text, "html.parser")

        selectedList = soup.select("#section-list ul li")
        if selectedList == []:
            print("기사가 없습니다.")
            break

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
                    "title": temp.select_one(".titles a").text,
                    "url": temp.select_one(".titles a")["href"],
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

    content = newsContent.text.replace("\n", "").replace("\t", "").lstrip().rstrip()
    news["content"] = content


def save_to_csv(news_list):
    print("csv 변환 중...")
    today = date.today()
    formatted_date = str(today).replace("-", "")
    formatted_date = int(formatted_date) - 1
    output_file_name = f"output/WeeklyChosun{formatted_date}.csv"
    with open(output_file_name, "w", encoding="utf-8") as output_file:
        csvwriter = csv.writer(output_file, delimiter=";")
        csvwriter.writerow(news_list[0].keys())
        for i in news_list:
            print(i.values())
            csvwriter.writerow(i.values())


# Press the green button in the gutter to run the script.
if __name__ == "__main__":
    news_list = get_news()
    print(news_list)
    print("본문 가져오는 중...")
    for news in news_list:
        get_content(news)
    save_to_csv(news_list)


def start():
    news_list = get_news()
    print(news_list)
    print("본문 가져오는 중...")
    for news in news_list:
        get_content(news)
    save_to_csv(news_list)
    print("완료")
    return news_list
