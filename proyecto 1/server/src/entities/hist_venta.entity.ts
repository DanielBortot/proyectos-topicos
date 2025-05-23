import { Column, Entity, ManyToOne, PrimaryColumn } from "typeorm";
import { Venta } from "./venta.entity";
import { Inventario } from "./inventario.entity";

@Entity('Hist_Venta')
export class Hist_Venta {
    @PrimaryColumn('date')
    fecha: string;

    @Column('integer')
    cantVend: number;

    @ManyToOne(() => Venta, venta => venta.id)
    venta: Venta;

    @ManyToOne(() => Inventario, inventario => inventario.id)
    inventario: Inventario;

    @PrimaryColumn()
    ventaId: number;

    @PrimaryColumn()
    inventarioId: number;
}