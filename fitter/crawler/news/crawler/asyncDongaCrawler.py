import requests
from datetime import date
from bs4 import BeautifulSoup
import csv
import concurrent.futures
import time

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36"
}


def get_news():
    today = date.today()
    formatted_date = str(today).replace("-", "")
    formatted_date = int(formatted_date) - 1
    page = 1
    news_list = []
    while True:
        print("뉴스 목록 가져오는 중... - page : {}", page)
        url = f"https://www.donga.com/news/List?p={page}&prod=news&ymd={formatted_date}&m="
        rq = requests.get(url, headers=headers)
        soup = BeautifulSoup(rq.text, "html.parser")
        selectedList = soup.select(".articleList.article_list")
        if selectedList[0].getText() == "해당 기사가 없습니다. ":
            break
        for temp in selectedList:
            news_list.append(
                {
                    "title": temp.select_one(".tit a").text,
                    "url": temp.select_one(".tit a")["href"],
                }
            )
        page += 20

    return news_list


def get_content(news):
    rq = requests.get(news["url"], headers=headers)
    soup = BeautifulSoup(rq.text, "html.parser")

    newsContent = soup.select_one("#article_txt")

    # ".article_issue.article_issue02" 클래스를 가진 요소 제거
    for element in newsContent.select(".article_issue.article_issue02"):
        element.extract()

    # ".article_footer" 클래스를 가진 요소 제거
    for element in newsContent.select(".article_footer"):
        element.extract()

    for element in newsContent.select(".articlePhotoC"):
        element.extract()

    for element in newsContent.select(".adwrap_box"):
        element.extract()

    for element in newsContent.select(".armerica_ban"):
        element.extract()

    for element in newsContent.select(".sub_title"):
        element.extract()

    content = newsContent.text.replace("\n", "").replace("\t", "").replace("\r", "").lstrip().rstrip()
    news["content"] = content


def save_to_csv(news_list):
    print("csv 변환 중...")
    today = date.today()
    formatted_date = str(today).replace("-", "")
    formatted_date = int(formatted_date) - 1
    output_file_name = f"output/DongaNews{formatted_date}.csv"
    with open(output_file_name, "w", encoding="utf-8") as output_file:
        csvwriter = csv.writer(output_file, delimiter=";")
        csvwriter.writerow(news_list[0].keys())
        for i in news_list:
            csvwriter.writerow(i.values())

def start():
    start_time = time.time()
    news_list = get_news()
    print("본문 가져오는 중...")
    with concurrent.futures.ThreadPoolExecutor() as executor:
        executor.map(get_content, news_list)
    save_to_csv(news_list)
    end_time = time.time()
    print("걸린시간 :", end_time - start_time)
    print("가져온 기사 :", news_list.__sizeof__())
    print("완료")
    return news_list
