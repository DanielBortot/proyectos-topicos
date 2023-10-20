import { Check, Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Hist_Salarios } from "./hist_salarios.entity";
import { Hist_Asistencia } from "./hist_asistencia.entity";

@Entity('Empleado')
@Check('"cedula" >= 1000000 and "cedula" <= 100000000')
export class Empleado {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('varchar', {
        length: 50
    })
    primerNombre: string;

    @Column('varchar', {
        length: 50
    })
    primerApellido: string;

    @Column('varchar', {
        length: 50,
        nullable: true
    })
    segundoNombre: string;

    @Column('varchar', {
        length: 50,
        nullable: true
    })
    segundoApellido: string;

    @Column('varchar', {
        length: 11
    })
    telefono: string;

    @Column('integer', {
        unique: true
    })
    cedula: number;

    @OneToMany(() => Hist_Salarios, hist_salarios => hist_salarios.empleado)
    histSueldo: Hist_Salarios[];

    @OneToMany(() => Hist_Asistencia, hist_asistencia => hist_asistencia.empleado)
    asistencias: Hist_Asistencia[];
}