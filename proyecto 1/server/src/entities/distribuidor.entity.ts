import { Check, Column, Entity, ManyToMany, ManyToOne, OneToMany, PrimaryColumn, PrimaryGeneratedColumn } from "typeorm";
import { Hist_Inventario } from "./hist_inventario.entity";
import { Ciudad } from "./ciudad.entity";

@Entity('Distribuidor')
@Check('"rif" > 1000000 and "rif" < 100000000')
export class Distribuidor {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('varchar', {
        length: 50,
        unique: true
    })
    nombre: string;
    
    @Column('varchar', {
        length: 11
    })
    telefono: string;

    @Column('integer', {
        unique: true
    })
    rif: number;

    @OneToMany(() => Hist_Inventario, hist_inv => hist_inv.distribuidor)
    inventariosDist: Hist_Inventario[];

    @ManyToOne(() => Ciudad, ciudad => ciudad.distribuidores)
    ciudad: Ciudad;
}