import { Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';

@Injectable()
export class PruebaService {

    constructor(private readonly dataSource: DataSource) {}

    async prueba() {
        const queryRunner = this.dataSource.createQueryRunner();
        await queryRunner.connect();
        const h = await queryRunner.query('SELECT * FROM saludo()')
        await queryRunner.release();
        console.log(h);
        return h;
    }
}
