import { Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';

@Injectable()
export class ReportesService {
    constructor(private readonly dataSource: DataSource) {}

    async reporte1() {
        const queryRunner = this.dataSource.createQueryRunner();
        await queryRunner.connect();
        const result = queryRunner.query('SELECT * FROM reporte1()');
        await queryRunner.release();
        return result;
    }

    async reporte2() {
        const queryRunner = this.dataSource.createQueryRunner();
        await queryRunner.connect();
        const result = queryRunner.query('SELECT * FROM reporte2()');
        await queryRunner.release();
        return result;
    }

    async reporte3() {
        const queryRunner = this.dataSource.createQueryRunner();
        await queryRunner.connect();
        const result = queryRunner.query('SELECT * FROM reporte3()');
        await queryRunner.release();
        return result;
    }

    async reporte4() {
        const queryRunner = this.dataSource.createQueryRunner();
        await queryRunner.connect();
        const result = queryRunner.query('SELECT * FROM reporte4()');
        await queryRunner.release();
        return result;
    }

    async reporte5() {
        const queryRunner = this.dataSource.createQueryRunner();
        await queryRunner.connect();
        const result = queryRunner.query('SELECT * FROM reporte5()');
        await queryRunner.release();
        return result;
    }

    async reporte6() {
        const queryRunner = this.dataSource.createQueryRunner();
        await queryRunner.connect();
        const result = queryRunner.query('SELECT * FROM reporte6()');
        await queryRunner.release();
        return result;
    }

    async reporte7(ciudad: string) {
        const queryRunner = this.dataSource.createQueryRunner();
        await queryRunner.connect();
        const result = queryRunner.query('SELECT * FROM reporte7(?)', [ciudad]);
        await queryRunner.release();
        return result;
    }

    async reporte8(inflacion: number) {
        const queryRunner = this.dataSource.createQueryRunner();
        await queryRunner.connect();
        const result = queryRunner.query(`SELECT * FROM reporte8(${inflacion})`);
        await queryRunner.release();
        return result;
    }
}
