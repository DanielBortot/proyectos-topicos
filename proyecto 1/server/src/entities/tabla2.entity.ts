import { Column, Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm";
import { Tabla1 } from "./tabla.entity";

@Entity('Tabla2')
export class Tabla2 {
    @Column('text')
    msg2: string;

    @ManyToOne(() => Tabla1, tabla1 => tabla1.id)
    @JoinColumn({name: 'id_tablaPrim'})
    tablaPrim: Tabla1;

    @PrimaryColumn()
    id_tablaPrim: number;
}