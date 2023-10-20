import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";

@Entity('Producto')
export class Producto {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('varchar', {
        length: 100,
        unique: true
    })
    nombre: string;

    @Column('text', {
        nullable: true
    })
    descripcion: string;
}