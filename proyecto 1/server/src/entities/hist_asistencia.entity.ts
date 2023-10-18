import { Column, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Empleado } from "./empleado.entity";
import { Venta } from "./venta.entity";

@Entity('Hist_Asistencia')
export class Hist_Asistencia {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('date')
    fecha: string;
    
    @ManyToOne(() => Empleado, empleado => empleado.asistencias)
    empleado: Empleado;

    @OneToMany(() => Venta, venta => venta.asistencia)
    ventas: Venta[];
}