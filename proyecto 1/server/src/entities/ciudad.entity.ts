import { Column, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Estado } from "./estado.entity";
import { Inventario } from "./inventario.entity";
import { Distribuidor } from "./distribuidor.entity";

@Entity('Ciudad')
export class Ciudad {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('varchar', {
        length: 50,
        unique: true
    })
    nombre: string;

    @ManyToOne(() => Estado, estado => estado.ciudades)
    estado: Estado;

    @OneToMany(() => Inventario, inventario => inventario.ciudad)
    inventariosCiudad: Inventario[];

    @OneToMany(() => Distribuidor, distribuidor => distribuidor.ciudad)
    distribuidores: Distribuidor[];
}