import { MigrationInterface, QueryRunner } from "typeorm";

export class Prueba1697300871875 implements MigrationInterface {
    name = 'Prueba1697300871875'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "tabla" ("id" SERIAL NOT NULL, "msg" text NOT NULL, CONSTRAINT "PK_5ac5a7cd75c0c16c467a7c4f1ba" PRIMARY KEY ("id"))`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP TABLE "tabla"`);
    }

}
