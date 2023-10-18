import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Empleado } from "./empleado.entity";

@Entity('Hist_Salarios')
export class Hist_Salarios {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('text')
    numContrato: string;

    @Column('integer')
    sueldoQuinc: number;

    @Column('date')
    fechaIni: string;

    @Column('date')
    fechaFin: string;

    @ManyToOne(() => Empleado, empleado => empleado.sueldos)
    empleado: Empleado;
}