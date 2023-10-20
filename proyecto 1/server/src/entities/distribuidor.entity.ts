import { Check, Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Ciudad } from "./ciudad.entity";

@Entity('Distribuidor')
@Check('"rif" > 1000000 and "rif" < 100000000')
export class Distribuidor {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('varchar', {
        length: 50,
        unique: true
    })
    nombre: string;
    
    @Column('varchar', {
        length: 11
    })
    telefono: string;

    @Column('integer', {
        unique: true
    })
    rif: number;

    @ManyToOne(() => Ciudad, ciudad => ciudad.id)
    ciudad: Ciudad;
}