import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Inventario } from "./inventario.entity";

@Entity('Producto')
export class Producto {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('varchar', {
        length: 100
    })
    nombre: string;

    @Column('text')
    descripcion: string;

    @OneToMany(() => Inventario, inventario => inventario.producto)
    inventariosProduc: Inventario[];
}