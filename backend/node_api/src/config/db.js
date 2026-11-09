import pg from 'pg';
import { env } from './env.js';

const { Pool } = pg;

export const pool = new Pool({
  connectionString: env.databaseUrl || undefined,
  max: 10,
  idleTimeoutMillis: 30_000,
  connectionTimeoutMillis: 5_000,
});

pool.on('error', (error) => {
  console.error('[db] Unexpected PostgreSQL pool error:', error.message);
});

export function query(text, params) {
  return pool.query(text, params);
}

export async function checkDatabaseConnection() {
  if (!env.databaseUrl) {
    return { connected: false, reason: 'DATABASE_URL is not configured' };
  }

  try {
    await pool.query('SELECT 1');
    return { connected: true };
  } catch (error) {
    return { connected: false, reason: error.message };
  }
}

export async function closeDatabase() {
  await pool.end();
}
