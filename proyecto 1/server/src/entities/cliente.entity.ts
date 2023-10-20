import { Check, Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Venta } from "./venta.entity";

@Entity('Cliente')
@Check('"cedula" >= 1000000 and "cedula" <= 100000000')
export class Cliente {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('varchar', {
        length: 50
    })
    primerNombre: string;

    @Column('varchar', {
        length: 50
    })
    primerApellido: string;

    @Column('varchar', {
        length: 50,
        nullable: true
    })
    segundoNombre: string;

    @Column('varchar', {
        length: 50,
        nullable: true
    })
    segundoApellido: string;

    @Column('varchar', {
        length: 11
    })
    telefono: string;

    @Column('integer', {
        unique: true
    })
    cedula: number;

    @OneToMany(() => Venta, venta => venta.cliente)
    ventas: Venta[];
}