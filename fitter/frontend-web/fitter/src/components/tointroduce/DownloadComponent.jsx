function DownloadComponent() {

    const handleImageClick = () => {
        window.open('https://www.naver.com', '_blank');
      };

    return (
        <div className="DownloadComponent">
            <h1>다운로드 페이지</h1>
            <div>
                어플을 다운받고 싶나요?
            </div>
            <div>
                <img src="imgs/download.jpg"
                alt="download"
                onClick={handleImageClick}
                style={{ cursor: 'pointer' }}
                />
            </div>
        </div>
    )
}

export default DownloadComponent