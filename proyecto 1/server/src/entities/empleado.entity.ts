import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Hist_Salarios } from "./hist_salarios.entity";
import { Hist_Asistencia } from "./hist_asistencia.entity";

@Entity('Empleado')
export class Empleado {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('varchar', {
        length: 50
    })
    nombre: string;

    @Column('varchar', {
        length: 50
    })
    apellido: string;

    @Column('varchar', {
        length: 11
    })
    telefono: string;

    @Column('varchar', {
        length: 8,
        unique: true
    })
    cedula: string;

    @OneToMany(() => Hist_Salarios, hist_salarios => hist_salarios.empleado)
    sueldos: Hist_Salarios[];

    @OneToMany(() => Hist_Asistencia, hist_asistencia => hist_asistencia.empleado)
    asistencias: Hist_Asistencia[];
}