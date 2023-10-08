import { ConfigService } from "@nestjs/config";
import { config } from "dotenv";
import { DataSource } from "typeorm";

config();

const configService = new ConfigService();

export default new DataSource({
    type: 'postgres',
    host: configService.getOrThrow('DATABASE_HOST'),
    port: configService.getOrThrow('DATABASE_PORT'),
    username: configService.getOrThrow('DATABASE_USERNAME'),
    password: configService.getOrThrow('DATABASE_PASSWORD'),
    database: configService.getOrThrow('DATABASE_NAME'),
    entities: ["src/entities/**/*.ts"],
    migrations: ["src/database/migrations/**/*.ts"]
})