-- Maintenance Management System - Supabase Schema
-- Run this in Supabase SQL Editor (Dashboard → SQL Editor → New Query)

-- Tasks table
CREATE TABLE IF NOT EXISTS tasks (
  id TEXT PRIMARY KEY,
  title TEXT,
  machine TEXT,
  zone TEXT,
  type TEXT,
  priority TEXT,
  tech TEXT,
  due TEXT,
  recur TEXT,
  "desc" TEXT,
  status TEXT DEFAULT 'todo',
  created_at TEXT,
  completed_at TEXT
);

-- Intervention logs
CREATE TABLE IF NOT EXISTS logs (
  id TEXT PRIMARY KEY,
  date TEXT,
  machine TEXT,
  zone TEXT,
  type TEXT,
  symptom TEXT,
  root_cause TEXT,
  diag_time INT DEFAULT 0,
  repair_time INT DEFAULT 0,
  repeat BOOLEAN DEFAULT false,
  parts TEXT,
  spare BOOLEAN DEFAULT false,
  technician TEXT,
  notes TEXT
);

-- Alerts
CREATE TABLE IF NOT EXISTS alerts (
  id TEXT PRIMARY KEY,
  machine TEXT,
  zone TEXT,
  "desc" TEXT,
  urgency TEXT,
  reporter TEXT,
  time TEXT,
  status TEXT DEFAULT 'open',
  claimed_by TEXT,
  claim_time TEXT,
  resolved_time TEXT
);

-- Machines
CREATE TABLE IF NOT EXISTS machines (
  id TEXT PRIMARY KEY,
  name TEXT,
  type TEXT,
  zone TEXT,
  notes TEXT
);

-- Enable real-time on all tables
ALTER PUBLICATION supabase_realtime ADD TABLE tasks;
ALTER PUBLICATION supabase_realtime ADD TABLE logs;
ALTER PUBLICATION supabase_realtime ADD TABLE alerts;
ALTER PUBLICATION supabase_realtime ADD TABLE machines;

-- Disable RLS (simplest for internal factory use)
ALTER TABLE tasks DISABLE ROW LEVEL SECURITY;
ALTER TABLE logs DISABLE ROW LEVEL SECURITY;
ALTER TABLE alerts DISABLE ROW LEVEL SECURITY;
ALTER TABLE machines DISABLE ROW LEVEL SECURITY;
