import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity('Tabla1')
export class Tabla1 {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('text')
    msg: string;
}