
import '../../assets/ReporteBase.css'
import logo from '../../assets/logo.png';

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


import { Chart } from "react-google-charts";
import { useEffect, useState } from 'react';
import { DatosRep8 } from '../../types/datosRep8';
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

export default function Reporte8 () {

    const [inflacion, setInflacion] = useState<string>('');
    const [tabla, setTabla] = useState<DatosRep8[]>([]);
    const navigate = useNavigate();
    let data: any = [];
    useEffect(() => {
        (async () => {
            const res: DatosRep8[] = await (await axios.post('/reportes/reporte8', {inflacion: 0})).data;
            setTabla(res);
            data = res.map((dato) => {return [`${dato.nombre}-${dato.ciudad}`, dato.precio_inflado, dato.precio_original]});
            console.log(data)
        })();
    },[])

    function validacion (e: React.ChangeEvent<HTMLInputElement>) {
        
        if (/^[0-9]+(,[0-9]+)?$/.test(e.target.value) || e.target.value === '') {
            setInflacion(e.target.value);
        }
    }

    async function enviar () {
        let num;
        if (inflacion === '') {
            num = 0;
        }
        else {
            num = parseInt(inflacion);
        }
        const res: DatosRep8[] = await (await axios.post('/reportes/reporte8', {inflacion: num})).data;
        setTabla(res)
        data = res.map((dato) => {return [`${dato.nombre}-${dato.ciudad}`, dato.precio_inflado, dato.precio_original]});
    }
      
      function Graph() {
        data = tabla.map((dato) => {return [`${dato.nombre}-${dato.ciudad}`, dato.precio_inflado, dato.precio_original]});
        data.unshift(["Element", "Precio Inflado", "Precio Original"]);
        console.log(data)
        return ( <Chart chartType="ColumnChart" width="100%" height="400px" data={data} /> );
      }
      
        function CustomizedTables() {
          return (
            <TableContainer component={Paper}>
              <Table sx={{ minWidth: 700 }} aria-label="customized table">
                <TableHead>
                  <TableRow>
                    <StyledTableCell>Producto</StyledTableCell>
                    <StyledTableCell align="right">Descripcion</StyledTableCell>
                    <StyledTableCell align="right">Precio Normal</StyledTableCell>
                    <StyledTableCell align="right">Precio con Inflacion</StyledTableCell>
                    <StyledTableCell align="right">Diferencia de Precios</StyledTableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {tabla.map((dato) => (
                    <StyledTableRow key={dato.nombre}>
                      <StyledTableCell component="th" scope="row">
                        {dato.nombre}
                      </StyledTableCell>
                      <StyledTableCell align="right">{dato.descripcion}</StyledTableCell>
                      <StyledTableCell align="right">{dato.precio_original}$</StyledTableCell>
                      <StyledTableCell align="right">{dato.precio_inflado}$</StyledTableCell>
                      <StyledTableCell align="right">{dato.diferencia_precio}$</StyledTableCell>
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
                <h2> Reporte 8 Estimacion de precios de productos dado un porcentaje de inflacion </h2>
            </div>

            <div className='buttons'>
                <Button size="medium" variant="contained" onClick={() => navigate("/")} startIcon={<ArrowBackIcon />}> Regresar </Button>
            </div>

            {tabla.length > 0 && <div className='api'>
                <Graph></Graph>
            </div>}

            <div className='entrada'>
                <input type="text" value={inflacion} onChange={e => validacion(e)} placeholder='Inflacion en porcentaje'/>
                <button onClick={() => enviar()}>Enviar</button>
            </div>

            <div className='table' style={{width: '100%'}}>
                <CustomizedTables></CustomizedTables>
            </div>

        </div>

    )
}