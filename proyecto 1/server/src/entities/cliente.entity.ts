import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity('Cliente')
export class Cliente {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('varchar', {
        length: 50
    })
    nombre: string;

    @Column('varchar', {
        length: 50
    })
    apellido: string;

    @Column('varchar', {
        length: 11
    })
    telefono: string;

    @Column('varchar', {
        length: 8,
        unique: true
    })
    cedula: string;
}