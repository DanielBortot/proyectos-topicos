import { MigrationInterface, QueryRunner } from "typeorm";

export class Prueba1697822930986 implements MigrationInterface {
    name = 'Prueba1697822930986'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "Pais" ("id" SERIAL NOT NULL, "nombre" character varying(50) NOT NULL, CONSTRAINT "UQ_cc1641cb8eeb6c2143810168aed" UNIQUE ("nombre"), CONSTRAINT "PK_39588447e7618c9343867dd9ffc" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Estado" ("id" SERIAL NOT NULL, "nombre" character varying(50) NOT NULL, "paisId" integer, CONSTRAINT "UQ_144fc0d1d176b0cdbaef87ac1ee" UNIQUE ("nombre"), CONSTRAINT "PK_4b73b059a55f610f3d8e3637352" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Ciudad" ("id" SERIAL NOT NULL, "nombre" character varying(50) NOT NULL, "estadoId" integer, CONSTRAINT "UQ_413cab0b153607af3a13c8c9db2" UNIQUE ("nombre"), CONSTRAINT "PK_fea85b80b8e1989340f1ee72ae9" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Cliente" ("id" SERIAL NOT NULL, "primerNombre" character varying(50) NOT NULL, "primerApellido" character varying(50) NOT NULL, "segundoNombre" character varying(50), "segundoApellido" character varying(50), "telefono" character varying(11) NOT NULL, "cedula" integer NOT NULL, CONSTRAINT "UQ_0164d80ed73bc137a3ca3c439e5" UNIQUE ("cedula"), CONSTRAINT "CHK_b5e171975b4d114068c0ff0084" CHECK ("cedula" >= 1000000 and "cedula" <= 100000000), CONSTRAINT "PK_d6b00ec12b8a60095cc4389d35d" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Distribuidor" ("id" SERIAL NOT NULL, "nombre" character varying(50) NOT NULL, "telefono" character varying(11) NOT NULL, "rif" integer NOT NULL, "ciudadId" integer, CONSTRAINT "UQ_c0cde72799c4a14ea249144c651" UNIQUE ("nombre"), CONSTRAINT "UQ_c5cad2e2b05bf7621efb004b363" UNIQUE ("rif"), CONSTRAINT "CHK_caa9c5a6bddd973f297d49be1e" CHECK ("rif" > 1000000 and "rif" < 100000000), CONSTRAINT "PK_f888272d7ffa45cb55ad0926472" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Empleado" ("id" SERIAL NOT NULL, "primerNombre" character varying(50) NOT NULL, "primerApellido" character varying(50) NOT NULL, "segundoNombre" character varying(50), "segundoApellido" character varying(50), "telefono" character varying(11) NOT NULL, "cedula" integer NOT NULL, CONSTRAINT "UQ_1418caff1d02d66c3c25d3c0a12" UNIQUE ("cedula"), CONSTRAINT "CHK_0bd28047ff3184d030cdd800f6" CHECK ("cedula" >= 1000000 and "cedula" <= 100000000), CONSTRAINT "PK_c373686f40463ef2523ed0656de" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Producto" ("id" SERIAL NOT NULL, "nombre" character varying(100) NOT NULL, "descripcion" text, CONSTRAINT "UQ_6e86914f2eac7cf092dd634681c" UNIQUE ("nombre"), CONSTRAINT "PK_e7929944b382b76708c4881fbde" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Inventario" ("id" SERIAL NOT NULL, "cantidad" integer NOT NULL, "costoVenta" real NOT NULL, "productoId" integer, "ciudadId" integer, CONSTRAINT "PK_466f277b3f603fcbd34a908e54c" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Hist_Inventario" ("fecha" date NOT NULL, "costoUnidad" real NOT NULL, "cantidadComp" integer NOT NULL, "distribuidorId" integer NOT NULL, "inventarioId" integer NOT NULL, CONSTRAINT "PK_95912cda6f76ccbb3b190f41be1" PRIMARY KEY ("fecha", "distribuidorId", "inventarioId"))`);
        await queryRunner.query(`CREATE TABLE "Hist_Asistencia" ("fecha" date NOT NULL, "horaEntrada" TIMESTAMP NOT NULL, "horaSalida" TIMESTAMP, "empleadoId" integer NOT NULL, CONSTRAINT "PK_96169df3d96a9f9c01ad617d3e3" PRIMARY KEY ("fecha", "empleadoId"))`);
        await queryRunner.query(`CREATE TABLE "Hist_Salarios" ("numContrato" integer NOT NULL, "sueldoQuinc" integer NOT NULL, "fechaIni" date NOT NULL, "fechaFin" date, "empleadoId" integer NOT NULL, CONSTRAINT "CHK_41a2be8ae6dda4c74011bee1dc" CHECK ("sueldoQuinc" > 0), CONSTRAINT "CHK_5a78be3899c0c4bb53fae90f23" CHECK ("numContrato" > 0), CONSTRAINT "PK_a9a18e3b7d2dc41b43b718d20ea" PRIMARY KEY ("fechaIni", "empleadoId"))`);
        await queryRunner.query(`CREATE TABLE "Venta" ("id" SERIAL NOT NULL, "monto" real NOT NULL, "asistenciaFecha" date, "asistenciaEmpleadoId" integer, "clienteId" integer, CONSTRAINT "PK_2e7a31f0c6a99fe691dabfb2fa2" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "Hist_Venta" ("fecha" date NOT NULL, "cantVend" integer NOT NULL, "ventaId" integer NOT NULL, "inventarioId" integer NOT NULL, CONSTRAINT "PK_0aee21ff2b48773503ebe400e3d" PRIMARY KEY ("fecha", "ventaId", "inventarioId"))`);
        await queryRunner.query(`ALTER TABLE "Estado" ADD CONSTRAINT "FK_152ee037ef74338360ecc36e610" FOREIGN KEY ("paisId") REFERENCES "Pais"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Ciudad" ADD CONSTRAINT "FK_372e439864e090ab8c84c14aa7e" FOREIGN KEY ("estadoId") REFERENCES "Estado"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Distribuidor" ADD CONSTRAINT "FK_bc7fdeeb6f2723cbe7a5403371c" FOREIGN KEY ("ciudadId") REFERENCES "Ciudad"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Inventario" ADD CONSTRAINT "FK_1cad65396226ef93e837a07cde9" FOREIGN KEY ("productoId") REFERENCES "Producto"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Inventario" ADD CONSTRAINT "FK_3d6bc8cba608bdc54581d4fe560" FOREIGN KEY ("ciudadId") REFERENCES "Ciudad"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Hist_Inventario" ADD CONSTRAINT "FK_170ca4c983b28c4d157722ad0fa" FOREIGN KEY ("distribuidorId") REFERENCES "Distribuidor"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Hist_Inventario" ADD CONSTRAINT "FK_7384215dc057958a5ffb0e7adab" FOREIGN KEY ("inventarioId") REFERENCES "Inventario"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Hist_Asistencia" ADD CONSTRAINT "FK_83eb2c02bc023c1fa5ed35f8f70" FOREIGN KEY ("empleadoId") REFERENCES "Empleado"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Hist_Salarios" ADD CONSTRAINT "FK_bddb6727df27942db3d907946cd" FOREIGN KEY ("empleadoId") REFERENCES "Empleado"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Venta" ADD CONSTRAINT "FK_37959360e4e8e8b896a50024bee" FOREIGN KEY ("asistenciaFecha", "asistenciaEmpleadoId") REFERENCES "Hist_Asistencia"("fecha","empleadoId") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Venta" ADD CONSTRAINT "FK_11cdd9c57d4b477ebc05600a938" FOREIGN KEY ("clienteId") REFERENCES "Cliente"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Hist_Venta" ADD CONSTRAINT "FK_a40775d381235b86396bbae9f31" FOREIGN KEY ("ventaId") REFERENCES "Venta"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "Hist_Venta" ADD CONSTRAINT "FK_d365c6d69482d502ed8d8ecfa36" FOREIGN KEY ("inventarioId") REFERENCES "Inventario"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "Hist_Venta" DROP CONSTRAINT "FK_d365c6d69482d502ed8d8ecfa36"`);
        await queryRunner.query(`ALTER TABLE "Hist_Venta" DROP CONSTRAINT "FK_a40775d381235b86396bbae9f31"`);
        await queryRunner.query(`ALTER TABLE "Venta" DROP CONSTRAINT "FK_11cdd9c57d4b477ebc05600a938"`);
        await queryRunner.query(`ALTER TABLE "Venta" DROP CONSTRAINT "FK_37959360e4e8e8b896a50024bee"`);
        await queryRunner.query(`ALTER TABLE "Hist_Salarios" DROP CONSTRAINT "FK_bddb6727df27942db3d907946cd"`);
        await queryRunner.query(`ALTER TABLE "Hist_Asistencia" DROP CONSTRAINT "FK_83eb2c02bc023c1fa5ed35f8f70"`);
        await queryRunner.query(`ALTER TABLE "Hist_Inventario" DROP CONSTRAINT "FK_7384215dc057958a5ffb0e7adab"`);
        await queryRunner.query(`ALTER TABLE "Hist_Inventario" DROP CONSTRAINT "FK_170ca4c983b28c4d157722ad0fa"`);
        await queryRunner.query(`ALTER TABLE "Inventario" DROP CONSTRAINT "FK_3d6bc8cba608bdc54581d4fe560"`);
        await queryRunner.query(`ALTER TABLE "Inventario" DROP CONSTRAINT "FK_1cad65396226ef93e837a07cde9"`);
        await queryRunner.query(`ALTER TABLE "Distribuidor" DROP CONSTRAINT "FK_bc7fdeeb6f2723cbe7a5403371c"`);
        await queryRunner.query(`ALTER TABLE "Ciudad" DROP CONSTRAINT "FK_372e439864e090ab8c84c14aa7e"`);
        await queryRunner.query(`ALTER TABLE "Estado" DROP CONSTRAINT "FK_152ee037ef74338360ecc36e610"`);
        await queryRunner.query(`DROP TABLE "Hist_Venta"`);
        await queryRunner.query(`DROP TABLE "Venta"`);
        await queryRunner.query(`DROP TABLE "Hist_Salarios"`);
        await queryRunner.query(`DROP TABLE "Hist_Asistencia"`);
        await queryRunner.query(`DROP TABLE "Hist_Inventario"`);
        await queryRunner.query(`DROP TABLE "Inventario"`);
        await queryRunner.query(`DROP TABLE "Producto"`);
        await queryRunner.query(`DROP TABLE "Empleado"`);
        await queryRunner.query(`DROP TABLE "Distribuidor"`);
        await queryRunner.query(`DROP TABLE "Cliente"`);
        await queryRunner.query(`DROP TABLE "Ciudad"`);
        await queryRunner.query(`DROP TABLE "Estado"`);
        await queryRunner.query(`DROP TABLE "Pais"`);
    }

}
