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
import { DatosRep4 } from '../../types/datosRep4';
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

export default function Reporte4 () {

    const [tabla, setTabla] = useState<DatosRep4[]>([]);
    const navigate = useNavigate();

    useEffect(() => {
        (async () => {
            const res: DatosRep4[] = await (await axios.get('/reportes/reporte4')).data;
            setTabla(res);
        })();
      },[]);

    function Graph() {
      let data = tabla.map((dato) => {return [dato.nombre, parseInt(dato.ingresos)]});
      data.unshift(["Element", "Ingresos Obtenidos"]);
        return ( <Chart chartType="ColumnChart" width="100%" height="400px" data={data} /> );
    }

    function CustomizedTables() {
        return (
          <TableContainer component={Paper}>
            <Table sx={{ minWidth: 700 }} aria-label="customized table">
              <TableHead>
                <TableRow>
                  <StyledTableCell>Sucursal</StyledTableCell>
                  <StyledTableCell align="right">Ingresos Obtenidos</StyledTableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {tabla.map((dato) => (
                  <StyledTableRow key={dato.nombre}>
                    <StyledTableCell component="th" scope="row">
                      {dato.nombre}
                    </StyledTableCell>
                    <StyledTableCell align="right">{dato.ingresos}$</StyledTableCell>
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
                <h2> Reporte 4 Sucursal con mayores ingresos </h2>
            </div>

            <div className='buttons'>
                <Button size="medium" variant="contained" onClick={() => navigate("/")} startIcon={<ArrowBackIcon />}> Regresar </Button>
            </div>

            {tabla.length > 0 && <div className='api'>
                <Graph></Graph>
            </div>}

            <div className='table' style={{width: '100%'}}>
                <CustomizedTables></CustomizedTables>
            </div>

        </div>

    )
}