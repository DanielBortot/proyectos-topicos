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
import { DatosRep6 } from '../../types/datosRep6';
import axios from 'axios';
import Chart from 'react-google-charts';

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

export default function Reporte6 () {

  const [tabla, setTabla] = useState<DatosRep6[]>([]);
  const [ciudad, setCiudad] = useState<string>('Hatillo');
  const navigate = useNavigate();
  let data: any = [];

  useEffect(() => {
      (async () => {
          const res: DatosRep6[] = await (await axios.post('/reportes/reporte6', {ciudad})).data;
          setTabla(res);
          console.log(res)
      })();
    },[]);

  function validacion (e: React.ChangeEvent<HTMLInputElement>) {
        
      setCiudad(e.target.value);
  }

  async function enviar () {
      const res: DatosRep6[] = await (await axios.post('/reportes/reporte6', {ciudad})).data;
      setTabla(res)
      data = res.map((dato) => {return [dato.nombre_completo, parseInt(dato.totalasistencias)]});
  }

  function Graph() {
    data = tabla.map((dato) => {return [dato.nombre_completo, parseInt(dato.totalasistencias)]});
    data.unshift(["Element", "Total de Asistencias"]);
    return ( <Chart chartType="ColumnChart" width="100%" height="400px" data={data} /> );
}

    function CustomizedTables() {
      return (
        <TableContainer component={Paper}>
          <Table sx={{ minWidth: 700 }} aria-label="customized table">
            <TableHead>
              <TableRow>
                <StyledTableCell>Nombre Empleado</StyledTableCell>
                <StyledTableCell align="right">Cedula</StyledTableCell>
                <StyledTableCell align="right">Telefono</StyledTableCell>
                <StyledTableCell align="right">Total de Asistencias</StyledTableCell>
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
                  <StyledTableCell align="right">{dato.totalasistencias}</StyledTableCell>
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
                <h2> Reporte 6 Mejores empleados por sucursal (mayor cantidad de asistencias) </h2>
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