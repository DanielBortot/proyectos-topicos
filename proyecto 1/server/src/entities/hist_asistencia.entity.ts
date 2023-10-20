import { Column, Entity, ManyToOne, PrimaryColumn } from "typeorm";
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

    @ManyToOne(() => Empleado, empleado => empleado.id)
    empleado: Empleado;

    @PrimaryColumn()
    empleadoId: number; 
}