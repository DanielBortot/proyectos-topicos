import { Entity, OneToMany, PrimaryColumn, PrimaryGeneratedColumn } from "typeorm";
import { Hist_Inventario } from "./hist_inventario.entity";

@Entity('Distribuidor')
export class Distribuidor {
    @PrimaryGeneratedColumn()
    id: number;

    @OneToMany(() => Hist_Inventario, hist_inv => hist_inv.distribuidor)
    inventariosDist: Hist_Inventario[];
}