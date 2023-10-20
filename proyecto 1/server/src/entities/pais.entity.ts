import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity('Pais')
export class Pais {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('varchar', {
        length: 50,
        unique: true
    })
    nombre: string;
}