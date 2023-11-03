import { Body, Controller, Get, Post } from '@nestjs/common';
import { ReportesService } from './reportes.service';

@Controller('reportes')
export class ReportesController {

    constructor (private readonly reportesService: ReportesService) {}

    @Get('reporte1')
    reporte1 () {
        return this.reportesService.reporte1();
    }

    @Get('reporte2')
    reporte2 () {
        return this.reportesService.reporte2();
    }

    @Get('reporte3')
    reporte3 () {
        return this.reportesService.reporte3();
    }

    @Get('reporte4')
    reporte4 () {
        return this.reportesService.reporte4();
    }

    @Get('reporte5')
    reporte5 () {
        return this.reportesService.reporte5();
    }

    @Post('reporte6')
    reporte6 (@Body() body: {ciudad: string}) {
        return this.reportesService.reporte6(body.ciudad);
    }

    @Post('reporte7')
    reporte7 (@Body() body: {ciudad: string}) {
        return this.reportesService.reporte7(body.ciudad);
    }

    @Post('reporte8')
    reporte8 (@Body() body: {inflacion: number}) {
        return this.reportesService.reporte8(body.inflacion);
    }

}