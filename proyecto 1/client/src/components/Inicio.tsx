import '../assets/Inicio.css'
import '../assets/ReporteBase.css'
import logo from '../assets/logo.png';
import fondo from '../assets/fondo2.jpg';

import { Link } from 'react-router-dom';

export default function Inicio () {

    return( 
        <div style={{ backgroundImage: `url(${fondo})` }}>

        <div className='logoContainer'>
            <img src={logo} alt="" />
                </div>
        <div className='container'>
            <div className='botonesCont'>
                <Link className='caja' to={'/reporte1'}>Reporte 1 Producto Mas vendido</Link>
                <Link className='caja' to={'/reporte2'}>Reporte 2 Nuevos productos por distribuidor</Link>
                <Link className='caja' to={'/reporte3'}>Reporte 3 Sucursal con mayores ventas</Link>
                <Link className='caja' to={'/reporte4'}>Reporte 4 Sucursal con mayores ingresos</Link>
                <Link className='caja' to={'/reporte5'}>Reporte 5 Producto con mas ingresos</Link>
                <Link className='caja' to={'/reporte6'}>Reporte 6 Mejores empleados por sucursal (mayor cantidad de asistencias) </Link>
                <Link className='caja' to={'/reporte7'}>Reporte 7 Rendimiento de empleados por sucursal (mayor cantidad de ventas) </Link>
                <Link className='caja' to={'/reporte8'}>Reporte 8 Estimacion de precios de productos dado un porcentaje de inflacion </Link>
            </div>
        </div>
    </div>
    );
}