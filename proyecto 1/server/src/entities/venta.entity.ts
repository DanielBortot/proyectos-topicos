import { Column, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Hist_Asistencia } from "./hist_asistencia.entity";
import { Hist_Venta } from "./hist_venta.entity";
import { Cliente } from "./cliente.entity";

@Entity('Venta')
export class Venta {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('real', {
        scale: 2
    })
    monto: number;

    @ManyToOne(() => Hist_Asistencia, hist_asistencias => hist_asistencias.empleado)
    asistencia: Hist_Asistencia;

    @ManyToOne(() => Cliente, cliente => cliente.id)
    cliente: Cliente;
}