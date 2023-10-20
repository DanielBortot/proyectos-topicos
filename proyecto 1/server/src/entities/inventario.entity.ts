import { Column, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Hist_Venta } from "./hist_venta.entity";
import { Producto } from "./producto.entity";
import { Ciudad } from "./ciudad.entity";
import { Hist_Inventario } from "./hist_inventario.entity";

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

    @OneToMany(() => Hist_Venta, hist_venta => hist_venta.inventario)
    producInv: Hist_Venta[];

    @OneToMany(() => Hist_Inventario, hist_inv => hist_inv.inventario)
    inventariosInv: Hist_Inventario[];

    @ManyToOne(() => Producto, producto => producto.inventariosProduc)
    producto: Producto;

    @ManyToOne(() => Ciudad, ciudad => ciudad.inventariosCiudad)
    ciudad: Ciudad;
}