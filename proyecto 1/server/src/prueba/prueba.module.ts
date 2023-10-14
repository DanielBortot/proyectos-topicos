import { Module } from '@nestjs/common';
import { PruebaController } from './prueba.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PruebaService } from './prueba.service';

@Module({
  imports: [],
  controllers: [PruebaController],
  providers: [PruebaService]
})
export class PruebaModule {}
