import { Check, Column, Entity, ManyToOne, PrimaryColumn } from "typeorm";
import { Empleado } from "./empleado.entity";

@Entity('Hist_Salarios')
@Check('"numContrato" > 0')
@Check('"sueldoQuinc" > 0')
export class Hist_Salarios {
    @Column('integer')
    numContrato: number;

    @Column('integer')
    sueldoQuinc: number;

    @PrimaryColumn('date')
    fechaIni: string;

    @Column('date', {
        nullable: true
    })
    fechaFin: string;

    @ManyToOne(() => Empleado, empleado => empleado.id)
    empleado: Empleado;

    @PrimaryColumn()
    empleadoId: number;
}