import { Controller, Get } from '@nestjs/common';

@Controller('prueba')
export class PruebaController {

    @Get('saludo')
    function () {
        return 'saludo';
    }
}
