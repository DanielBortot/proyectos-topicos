import { Column, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Pais } from "./pais.entity";
import { Ciudad } from "./ciudad.entity";

@Entity('Estado')
export class Estado {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('varchar', {
        length: 50
    })
    nombre: string;

    @ManyToOne(() => Pais, pais => pais.estados)
    pais: Pais;

    @OneToMany(() => Ciudad, ciudad => ciudad.estado)
    ciudades: Ciudad[];
}