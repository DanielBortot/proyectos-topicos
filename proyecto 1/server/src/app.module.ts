import { Module } from '@nestjs/common';
import { DatabaseModule } from './database/database.module';
import { ConfigModule } from '@nestjs/config';
import { PruebaModule } from './prueba/prueba.module';

@Module({
  imports: [ConfigModule.forRoot({}), DatabaseModule, PruebaModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
