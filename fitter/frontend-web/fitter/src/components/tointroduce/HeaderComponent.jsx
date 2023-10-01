import { Link } from "react-router-dom"

function HeaderComponent() {

    return (
        <header className="border-bottom border-light border-5 mb-5 p-2">
        <div className="container">
            <div className="row">
                <nav className="navbar navbar-expand-lg">
                    <Link className="navbar-brand ms-2 fs-2 fw-bold text-black" to="/">FITTER</Link>
                    <div className="collapse navbar-collapse">
                        <ul className="navbar-nav">
                            <li className="nav-item fs-5">
                                <Link className="nav-link" to="/crossfit">크로스핏 이란?</Link></li>
                            <li className="nav-item fs-5">
                               <Link className="nav-link" to="/feature">대표 기능</Link></li>
                            <li className="nav-item fs-5">
                                <Link className="nav-link" to="/download">다운로드</Link></li>   
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
    </header>
    )
}

export default HeaderComponent