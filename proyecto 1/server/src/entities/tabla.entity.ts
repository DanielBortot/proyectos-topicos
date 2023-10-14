import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity('tabla')
export class Tabla {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('text')
    msg: string;
}