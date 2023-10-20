import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Estado } from "./estado.entity";

@Entity('Pais')
export class Pais {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('varchar', {
        length: 50,
        unique: true
    })
    nombre: string;

    @OneToMany(() => Estado, estado => estado.pais)
    estados: Estado[];
}