

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
import { DatosRep3 } from '../../types/datosRep3';
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

export default function Reporte3 () {

    const [tabla, setTabla] = useState<DatosRep3[]>([]);
    const navigate = useNavigate();

    useEffect(() => {
        (async () => {
            //const res: DatosRep3[] = await (await axios.get('')).data;
            //setTabla(res);
        })();
      },[]);

    let data = tabla.map((dato) => {return [dato.nombre, dato.ventas]});
    data.unshift(["Element", "Ventas Hechas"]);
    
    function Graph() {
      return ( <Chart chartType="ColumnChart" width="100%" height="400px" data={data} /> );
    }

    function CustomizedTables() {
        return (
          <TableContainer component={Paper}>
            <Table sx={{ minWidth: 700 }} aria-label="customized table">
              <TableHead>
                <TableRow>
                  <StyledTableCell>Sucursal</StyledTableCell>
                  <StyledTableCell align="right">Ventas Hechas</StyledTableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {tabla.map((dato) => (
                  <StyledTableRow key={dato.nombre}>
                    <StyledTableCell component="th" scope="row">
                      {dato.nombre}
                    </StyledTableCell>
                    <StyledTableCell align="right">{dato.ventas}</StyledTableCell>
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
                <h2> Reporte 3 Sucursal con mayores ventas </h2>
            </div>

            <div className='buttons'>
                <Button size="medium" variant="contained" onClick={() => navigate("/")} startIcon={<ArrowBackIcon />}> Regresar </Button>
            </div>

            <div className='api'>
                <Graph></Graph>
            </div>

            <div className='table' style={{width: '100%'}}>
                <CustomizedTables></CustomizedTables>
            </div>

        </div>

    )
}