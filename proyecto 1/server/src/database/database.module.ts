import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
    imports: [TypeOrmModule.forRootAsync({
        imports: [ConfigModule],
        inject: [ConfigService],
        useFactory: (configService: ConfigService) => ({
            type: 'postgres',
            host: configService.getOrThrow('DATABASE_HOST'),
            port: configService.getOrThrow('DATABASE_PORT'),
            username: configService.getOrThrow('DATABASE_USERNAME'),
            password: configService.getOrThrow('DATABASE_PASSWORD'),
            database: configService.getOrThrow('DATABASE_NAME'),
            autoLoadEntities: true ? configService.getOrThrow('DATABASE_AUTOLOAD') == 'true': false,
            logging:  true ? configService.getOrThrow('DATABASE_LOGGING') == 'true': false,
            synchronize: true ? configService.getOrThrow('DATABASE_SYNCHRONIZE') == 'true': false 
        })
    })]
})
export class DatabaseModule {}
