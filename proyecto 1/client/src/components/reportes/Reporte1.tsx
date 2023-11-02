
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
import TableChartIcon from '@mui/icons-material/TableChart';
import ArrowBackIcon from '@mui/icons-material/ArrowBack';


import { Chart } from "react-google-charts";

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

const rows = [
  createData('Frozen yoghurt', 'sdsd', 6),
  createData('Ice cream sandwich', 'sdsd', 6),
  createData('Eclair', 'sdsd', 6),
  createData('Cupcake', 'sdsd', 6),
  createData('Gingerbread', 'sdsd', 6),
];

const data = [
  ["Element", "Density", { role: "style" }],
  ["Copper", 8.94, "#rgb(66, 188, 249)"], // RGB value
  ["Silver", 10.49, "rgb(157, 203, 223)"], // English color name
  ["Gold", 19.3, "#rgb(66, 188, 249)"],
  ["Platinum", 21.45, "rgb(157, 203, 223)"], // CSS-style declaration
];

function Graph() {
  return ( <Chart chartType="ColumnChart" width="100%" height="400px" data={data} /> );
}

function createData(
  producto: string,
  descripcion: string,
  cantVend: number
) {
  return { producto, descripcion, cantVend };
}

function CustomizedTables() {
  return (
    <TableContainer component={Paper}>
      <Table sx={{ minWidth: 700 }} aria-label="customized table">
        <TableHead>
          <TableRow>
            <StyledTableCell>Producto</StyledTableCell>
            <StyledTableCell align="right">Descripcion</StyledTableCell>
            <StyledTableCell align="right">Cantidad Vendidas</StyledTableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {rows.map((row) => (
            <StyledTableRow key={row.producto}>
              <StyledTableCell component="th" scope="row">
                {row.producto}
              </StyledTableCell>
              <StyledTableCell align="right">{row.descripcion}</StyledTableCell>
              <StyledTableCell align="right">{row.cantVend}</StyledTableCell>
            </StyledTableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
  );
}

export default function Reporte1 () {

    const navigate = useNavigate();

    return(
        <div className='main'>

            <div className='title'>
                <div className='logoContainer'>
                  <img src={logo} alt="" />
                </div>
                <h2> Reporte 1 Producto Mas vendido </h2>
            </div>

            <div className='buttons'>
                <Button size="medium" variant="contained" onClick={() => navigate("/")} startIcon={<ArrowBackIcon />}> Regresar </Button>
                <div className='space'></div>
                <Button size="medium" variant="contained" onClick={() => navigate("/reporte1/subreporte")} startIcon={<TableChartIcon />} > Mostrar mas datos </Button>
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