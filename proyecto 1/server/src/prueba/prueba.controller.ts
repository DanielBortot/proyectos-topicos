import { Controller, Get } from '@nestjs/common';
import { PruebaService } from './prueba.service';

@Controller('prueba')
export class PruebaController {

    constructor(private pruebaService: PruebaService) {}

    @Get('saludo')
    prueba () {
        return this.pruebaService.prueba();
    }
}
