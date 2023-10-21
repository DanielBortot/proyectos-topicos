import '../assets/Inicio.css'
import { Link } from 'react-router-dom';

export default function Inicio () {

    return(
        <div className='container'>
            <div className='botonesCont'>
                <Link className='caja' to={'/reporte1'}>Reporte 1</Link>
                <Link className='caja' to={'/reporte2'}>Reporte 2</Link>
                <Link className='caja' to={'/reporte3'}>Reporte 3</Link>
                <Link className='caja' to={'/reporte4'}>Reporte 4</Link>
                <Link className='caja' to={'/reporte5'}>Reporte 5</Link>
                <Link className='caja' to={'/reporte6'}>Reporte 6</Link>
                <Link className='caja' to={'/reporte7'}>Reporte 7</Link>
                <Link className='caja' to={'/reporte8'}>Reporte 8</Link>
            </div>
        </div>
    );
}