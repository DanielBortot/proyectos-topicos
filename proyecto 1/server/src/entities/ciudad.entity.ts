import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Estado } from "./estado.entity";

@Entity('Ciudad')
export class Ciudad {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('varchar', {
        length: 50,
        unique: true
    })
    nombre: string;

    @ManyToOne(() => Estado, estado => estado.id)
    estado: Estado;
}