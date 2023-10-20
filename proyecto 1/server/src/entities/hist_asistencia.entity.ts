import { Column, Entity, ManyToOne, OneToMany, PrimaryColumn, PrimaryGeneratedColumn } from "typeorm";
import { Empleado } from "./empleado.entity";
import { Venta } from "./venta.entity";

@Entity('Hist_Asistencia')
export class Hist_Asistencia {
    @PrimaryColumn('date')
    fecha: string;
    
    @Column('timestamp')
    horaEntrada: Date;

    @Column('timestamp', {
        nullable: true
    })
    horaSalida: Date;

    @ManyToOne(() => Empleado, empleado => empleado.asistencias)
    empleado: Empleado;

    @OneToMany(() => Venta, venta => venta.asistencia)
    ventas: Venta[];
}