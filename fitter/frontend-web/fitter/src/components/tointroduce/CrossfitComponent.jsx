function CrossfitComponent() {

    const description1 = '여러가지 운동을 섞어서 한다는 뜻의 크로스트레이닝(Cross Training) + 신체의 활동을 뜻하는 피트니스(Fitness)의 합성어';
    const description2 = '크로스핏은 전체적으로 신체 능력을 골고루 발달시키는 근력운동과 유산소 운동을 분리하지 않고 병행하게 한다.';
    

    return (
        <div className="CrossfitComponent">
            <h1>크로스핏이란?</h1>
            <div>
                <img src="imgs/crossfit-ex1.jpg" alt="crossfit-ex1" />
            </div>
            <div>
                {description1}
            </div>    
            <div>
                {description2}
            </div>
                
            
        </div>
    )
}

export default CrossfitComponent