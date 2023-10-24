import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";
import { Content } from "./abstracts/abstract";

@Entity('Tabla1')
export class Tabla1 extends Content{
    @PrimaryGeneratedColumn()
    id: number;

    @Column('text')
    msg: string;
}