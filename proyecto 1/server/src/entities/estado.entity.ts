import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Pais } from "./pais.entity";

@Entity('Estado')
export class Estado {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('varchar', {
        length: 50,
        unique: true
    })
    nombre: string;

    @ManyToOne(() => Pais, pais => pais.id)
    pais: Pais;
}