import '../../assets/ReporteBase.css'
import logo from '../../assets/logo.png';

import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { styled } from '@mui/material/styles';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell, { tableCellClasses } from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import Button from '@mui/material/Button';
import ArrowBackIcon from '@mui/icons-material/ArrowBack';
import { DatosRep7 } from '../../types/datosRep7';
import Chart from 'react-google-charts';
import axios from 'axios';

export const StyledTableCell = styled(TableCell)(({ theme }) => ({
    [`&.${tableCellClasses.head}`]: {
      backgroundColor: theme.palette.common.black,
      color: theme.palette.common.white,
    },
    [`&.${tableCellClasses.body}`]: {
      fontSize: 14,
    },
  }));
  
  export const StyledTableRow = styled(TableRow)(({ theme }) => ({
    '&:nth-of-type(odd)': { backgroundColor: theme.palette.action.hover, },
    '&:last-child td, &:last-child th': { border: 12, },
  }));

export default function Reporte7 () {

    const [tabla, setTabla] = useState<DatosRep7[]>([]);
    const [ciudad, setCiudad] = useState<string>('Hatillo');
    const navigate = useNavigate();
    let data: any = [];

    useEffect(() => {
        (async () => {
            const res: DatosRep7[] = await (await axios.post('/reportes/reporte7', {ciudad})).data;
            setTabla(res);
        })();
      },[]);

    function validacion (e: React.ChangeEvent<HTMLInputElement>) {
        
        setCiudad(e.target.value);
    }

    async function enviar () {
      const res: DatosRep7[] = await (await axios.post('/reportes/reporte7', {ciudad})).data;
      setTabla(res)
      data = res.map((dato) => {return [dato.nombre_completo, parseInt(dato.ventas)]});
  }

    function Graph() {
        data = tabla.map((dato) => {return [dato.nombre_completo, parseInt(dato.ventas)]});
        data.unshift(["Element", "Ventas Totales Realizadas"]);
        return ( <Chart chartType="ColumnChart" width="100%" height="400px" data={data} /> );
    }

    function CustomizedTables() {
        return (
          <TableContainer component={Paper}>
            <Table sx={{ minWidth: 700 }} aria-label="customized table">
              <TableHead>
                <TableRow>
                  <StyledTableCell>Nombre del Empleado</StyledTableCell>
                  <StyledTableCell align="right">Cedula</StyledTableCell>
                  <StyledTableCell align="right">Telefono</StyledTableCell>
                  <StyledTableCell align="right">Cantidad de Ventas Realizadas</StyledTableCell>
                  <StyledTableCell align="right">Ciudad</StyledTableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {tabla.map((dato) => (
                  <StyledTableRow key={dato.nombre_completo}>
                    <StyledTableCell component="th" scope="row">
                      {dato.nombre_completo}
                    </StyledTableCell>
                    <StyledTableCell align="right">{dato.cedula}</StyledTableCell>
                    <StyledTableCell align="right">{dato.telefono}</StyledTableCell>
                    <StyledTableCell align="right">{dato.ventas}</StyledTableCell>
                    <StyledTableCell align="right">{dato.ciudad}</StyledTableCell>
                  </StyledTableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
        );
      }

    return(
        <div className='main'>

            <div className='title'>
                <div className='logoContainer'>
                    <img src={logo} alt="" />
                </div>
                <h2> Reporte 7 Rendimiento de empleados por sucursal (mayor cantidad de ventas) </h2>
            </div>

            <div className='buttons'>
                <Button size="medium" variant="contained" onClick={() => navigate("/")} startIcon={<ArrowBackIcon />}> Regresar </Button>
            </div>

            {tabla.length > 0 && <div className='api'>
                <Graph></Graph>
            </div>}

            <div className='entrada'>
                <input type="text" value={ciudad} onChange={e => validacion(e)} placeholder='Ingresa la ciudad'/>
                <button onClick={() => enviar()}>Enviar</button>
            </div>

            <div className='table' style={{width: '100%'}}>
                <CustomizedTables></CustomizedTables>
            </div>

        </div>

    )
}