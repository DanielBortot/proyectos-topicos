import { Column, Entity, ManyToOne, PrimaryColumn } from "typeorm";
import { Distribuidor } from "./distribuidor.entity";
import { Inventario } from "./inventario.entity";

@Entity('Hist_Inventario')
export class Hist_Inventario {
    @Column('date')
    fecha: string;

    @Column('real', {
        scale: 2
    })
    costoUnidad: number;

    @Column('integer')
    cantidadComp: number;

    @ManyToOne(() => Distribuidor, distribuidor => distribuidor.inventariosDist)
    distribuidor: Distribuidor;

    @ManyToOne(() => Inventario, inventario => inventario.inventariosInv)
    inventario: Inventario;

    @PrimaryColumn()
    distribuidorId: number;

    @PrimaryColumn()
    inventarioId: number;
}