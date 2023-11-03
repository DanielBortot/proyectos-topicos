import { Module } from '@nestjs/common';
import { DatabaseModule } from './database/database.module';
import { ConfigModule } from '@nestjs/config';
import { ReportesModule } from './reportes/reportes.module';

@Module({
  imports: [ConfigModule.forRoot({}), DatabaseModule, ReportesModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
