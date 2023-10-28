import { Routes, Route } from "react-router-dom";
import Reporte1 from "./components/reportes/Reporte1";
import Reporte2 from "./components/reportes/Reporte2";
import Reporte3 from "./components/reportes/Reporte3";
import Reporte4 from "./components/reportes/Reporte4";
import Reporte5 from "./components/reportes/Reporte5";
import Reporte6 from "./components/reportes/Reporte6";
import Reporte7 from "./components/reportes/Reporte7";
import Reporte8 from "./components/reportes/Reporte8";
import Subreporte1 from "./components/reportes/Subreporte1";
import Inicio from "./components/Inicio";

function App() {
  return (
    <Routes>
      <Route path="/" element={<Inicio/>}/>

      <Route path="/reporte1" element={<Reporte1/>}/>
      <Route path="/reporte2" element={<Reporte2/>}/>
      <Route path="/reporte3" element={<Reporte3/>}/>
      <Route path="/reporte4" element={<Reporte4/>}/>
      <Route path="/reporte5" element={<Reporte5/>}/>
      <Route path="/reporte6" element={<Reporte6/>}/>
      <Route path="/reporte7" element={<Reporte7/>}/>
      <Route path="/reporte8" element={<Reporte8/>}/>
      <Route path="/reporte1/subreporte" element={<Subreporte1/>}/>
    </Routes>
  );
}

export default App;
