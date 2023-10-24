import { MigrationInterface, QueryRunner } from "typeorm";

export class PruebaAbstract1698176890364 implements MigrationInterface {
    name = 'PruebaAbstract1698176890364'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "Tabla1" ("msgPrueba" character varying NOT NULL, "msgPrueba2" character varying NOT NULL, "id" SERIAL NOT NULL, "msg" text NOT NULL, CONSTRAINT "PK_b616b1e9a8460a1bad5daae36cb" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Tabla2" ("msg2" text NOT NULL, "id_tablaPrim" integer NOT NULL, CONSTRAINT "PK_49cc38923037ac54798be3fe379" PRIMARY KEY ("id_tablaPrim"))`);
        await queryRunner.query(`ALTER TABLE "Tabla2" ADD CONSTRAINT "FK_49cc38923037ac54798be3fe379" FOREIGN KEY ("id_tablaPrim") REFERENCES "Tabla1"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Tabla2" DROP CONSTRAINT "FK_49cc38923037ac54798be3fe379"`);
        await queryRunner.query(`DROP TABLE "Tabla2"`);
        await queryRunner.query(`DROP TABLE "Tabla1"`);
    }

}
