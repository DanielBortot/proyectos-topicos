import { Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';

@Injectable()
export class ReportesService {
    constructor(private readonly dataSource: DataSource) {}

    async reporte() {
        const queryRunner = this.dataSource.createQueryRunner();
        await queryRunner.connect();
        const result = queryRunner.query('SELECT * FROM reporte()');
        await queryRunner.release();
        return result;
    }
}
