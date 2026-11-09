-- ============================================================
-- ShrimpGuard AI - Migration 001: Initial Schema
-- Team: CSE4104-7C-T04
--
-- The canonical DDL lives in:
--   database/schema/001_initial_schema.sql
--
-- This file applies that DDL in a single transaction using psql.
-- Run from the project root with:
--   psql "$DATABASE_URL" -f database/migrations/001_initial_schema.sql
--
-- A full migration runner (Node.js or Python) is To Be Confirmed.
-- ============================================================

\set ON_ERROR_STOP on

BEGIN;

\ir ../schema/001_initial_schema.sql

COMMIT;
