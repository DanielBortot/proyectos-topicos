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
import { DatosRep2 } from '../../types/datosRep2';

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

export default function Reporte2 () {

    const [tabla, setTabla] = useState<DatosRep2[]>([]);
    const navigate = useNavigate();

    useEffect(() => {
        (async () => {
            //const res: DatosRep2[] = await (await axios.get('')).data;
            //setTabla(res);
        })();
      },[]);

    function CustomizedTables() {
        return (
          <TableContainer component={Paper}>
            <Table sx={{ minWidth: 700 }} aria-label="customized table">
              <TableHead>
                <TableRow>
                  <StyledTableCell>Distribuidora</StyledTableCell>
                  <StyledTableCell align="right">Producto</StyledTableCell>
                  <StyledTableCell align="right">Fecha</StyledTableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {tabla.map((dato) => (
                  <StyledTableRow key={dato.distribuidor}>
                    <StyledTableCell component="th" scope="row">
                      {dato.distribuidor}
                    </StyledTableCell>
                    <StyledTableCell align="right">{dato.producto}</StyledTableCell>
                    <StyledTableCell align="right">{dato.fecha_inventario}</StyledTableCell>
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
                <h2> Reporte 2 Nuevos productos por distribuidor </h2>
            </div>

            <div className='buttons'>
                <Button size="medium" variant="contained" onClick={() => navigate("/")} startIcon={<ArrowBackIcon />}> Regresar </Button>
            </div>

            <div className='table' style={{width: '100%'}}>
                <CustomizedTables></CustomizedTables>
            </div>

        </div>

    )
}