import '../../assets/ReporteBase.css'
import logo from '../../assets/logo.png';

import { useState } from 'react'
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

function createData(
    producto: string,
    descripcion: string,
    precioOrig: number,
    precioInf: number,
    precioDif: number,
  ) {
    return { producto, descripcion, precioOrig, precioInf, precioDif };
  }

const rows = [
    createData('Frozen yoghurt', 'hola', 6.0, 24, 4.0),
    createData('Ice cream sandwich', 'hola', 9.0, 37, 4.3),
    createData('Eclair', 'hola', 16.0, 24, 6.0),
    createData('Cupcake', 'hola', 3.7, 67, 4.3),
    createData('Gingerbread', 'hola', 16.0, 49, 3.9),
  ];

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
            {rows.map((row) => (
              <StyledTableRow key={row.producto}>
                <StyledTableCell component="th" scope="row">
                  {row.producto}
                </StyledTableCell>
                <StyledTableCell align="right">{row.descripcion}$</StyledTableCell>
                <StyledTableCell align="right">{row.precioOrig}$</StyledTableCell>
                <StyledTableCell align="right">{row.precioInf}$</StyledTableCell>
                <StyledTableCell align="right">{row.precioDif}$</StyledTableCell>
              </StyledTableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
    );
  }

export default function Reporte8 () {

    const [inflacion, setInflacion] = useState<string>('');
    const navigate = useNavigate();

    function validacion (e: React.ChangeEvent<HTMLInputElement>) {
        
        if (/^[0-9]+(,[0-9]+)?$/.test(e.target.value) || e.target.value == '') {
            setInflacion(e.target.value);
        }
    }

    function enviar () {
        let num;
        if (inflacion == '') {
            num = 1;
        }
        else {
            num = parseInt(inflacion);
        }

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