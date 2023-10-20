import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Producto } from "./producto.entity";
import { Ciudad } from "./ciudad.entity";

@Entity('Inventario')
export class Inventario {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('integer')
    cantidad: number;

    @Column('real', {
        scale: 2
    })
    costoVenta: number;

    @ManyToOne(() => Producto, producto => producto.id)
    producto: Producto;

    @ManyToOne(() => Ciudad, ciudad => ciudad.id)
    ciudad: Ciudad;
}