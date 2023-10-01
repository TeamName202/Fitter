import { BrowserRouter, Routes, Route} from 'react-router-dom'
import HeaderComponent from './HeaderComponent'
import FooterComponent from './FooterComponent'
import ErrorComponent from './ErrorComponent'
import MainComponent from './MainComponent'
import CrossfitComponent from './CrossfitComponent'
import FeatureComponent from './FeatureComponent'
import DownloadComponent from './DownloadComponent'
import './TointroduceApp.css'

export default function TointroduceApp() {
    return (
        <div className="TointroduceApp">
            <BrowserRouter>
                <HeaderComponent />
                <Routes>
                    <Route path='/' element={<MainComponent />} />
                    <Route path='/crossfit' element={<CrossfitComponent />} />
                    <Route path='/feature' element={<FeatureComponent />} />
                    <Route path='/download' element={<DownloadComponent />} />
                    <Route path='*' element={<ErrorComponent />} />
                </Routes>
                <FooterComponent />
            </BrowserRouter>
        </div>
    )
}






