import { Column } from "typeorm";

export abstract class Content {
    @Column('varchar')
    msgPrueba: string;

    @Column('varchar')
    msgPrueba2: string;
}