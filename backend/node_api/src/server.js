import app from './app.js';
import { env } from './config/env.js';
import { checkDatabaseConnection, closeDatabase } from './config/db.js';

async function start() {
  const database = await checkDatabaseConnection();

  if (!database.connected) {
    console.warn(`[startup] Database not ready: ${database.reason}`);
  }

  const server = app.listen(env.port, () => {
    console.log(`[startup] ShrimpGuard API listening on port ${env.port} (${env.nodeEnv})`);
  });

  async function shutdown(signal) {
    console.log(`[shutdown] Received ${signal}. Closing server...`);
    server.close(async () => {
      await closeDatabase();
      process.exit(0);
    });
  }

  process.on('SIGINT', () => shutdown('SIGINT'));
  process.on('SIGTERM', () => shutdown('SIGTERM'));
}

start().catch((error) => {
  console.error('[startup] Failed to start API:', error);
  process.exit(1);
});
