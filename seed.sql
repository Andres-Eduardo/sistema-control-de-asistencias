-- ─────────────────────────────────────────────────────────────────────────────
-- seed.sql — Datos de demostración para el Sistema de Control de Asistencia
-- Ejecuta este script en Supabase → SQL Editor para poblar la base de datos
-- ─────────────────────────────────────────────────────────────────────────────

-- ── PASO 1: Crear tablas ──────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS bebes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre_bebe text NOT NULL,
  nombre_madre text,
  fase text,
  programa text,
  edad text
);

CREATE TABLE IF NOT EXISTS asistencias (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  bebe_id uuid REFERENCES bebes(id) ON DELETE CASCADE,
  dia text
);

CREATE TABLE IF NOT EXISTS registros_asistencia (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre_bebe text,
  nombre_madre text,
  fase text,
  programa text,
  edad text,
  fecha text,
  dia text,
  asistencia text,
  ubicacion text,
  reporte text,
  situacion_especifica text,
  nota text,
  extras text,
  no_cidi text
);

CREATE TABLE IF NOT EXISTS usuarios (
  id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email text NOT NULL,
  nombre text NOT NULL DEFAULT '',
  rol text NOT NULL CHECK (rol IN ('admin','coordinadora','profesora'))
);

-- ── PASO 2: Activar RLS ───────────────────────────────────────────────────────

ALTER TABLE bebes ENABLE ROW LEVEL SECURITY;
ALTER TABLE asistencias ENABLE ROW LEVEL SECURITY;
ALTER TABLE registros_asistencia ENABLE ROW LEVEL SECURITY;
ALTER TABLE usuarios ENABLE ROW LEVEL SECURITY;

CREATE POLICY "solo autenticados - bebes"
  ON bebes FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "solo autenticados - asistencias"
  ON asistencias FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "solo autenticados - registros"
  ON registros_asistencia FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "usuario puede leer su propio perfil"
  ON usuarios FOR SELECT USING (auth.uid() = id);

-- ── PASO 3: Insertar beneficiarios ficticios ──────────────────────────────────

INSERT INTO bebes (id, nombre_bebe, nombre_madre, fase, programa, edad) VALUES
  ('11111111-0001-0001-0001-000000000001', 'Valentina Rojas Pérez',     'Carmen Pérez Díaz',      'Nivel 1', 'Taller A', '6-15'),
  ('11111111-0001-0001-0001-000000000002', 'Samuel Gómez Torres',       'Luisa Torres Vargas',    'Nivel 1', 'Taller A', '16-30'),
  ('11111111-0001-0001-0001-000000000003', 'Isabella Martínez Cruz',    'Ana Cruz Herrera',       'Nivel 1', 'Taller B', '6-15'),
  ('11111111-0001-0001-0001-000000000004', 'Mateo Hernández Ruiz',      'Sandra Ruiz López',      'Nivel 1', 'Taller B', '16-30'),
  ('11111111-0001-0001-0001-000000000005', 'Sofía López Ramírez',       'Patricia Ramírez Mora',  'Nivel 2', 'Taller A', '6-15'),
  ('11111111-0001-0001-0001-000000000006', 'Alejandro Díaz Moreno',     'Gloria Moreno Salinas',  'Nivel 2', 'Taller A', '16-30'),
  ('11111111-0001-0001-0001-000000000007', 'Camila Vargas Castillo',    'Rosa Castillo Reyes',    'Nivel 2', 'Taller B', '6-15'),
  ('11111111-0001-0001-0001-000000000008', 'Sebastián Castro Jiménez',  'Marta Jiménez Suárez',   'Nivel 2', 'Taller C', '16-30'),
  ('11111111-0001-0001-0001-000000000009', 'Mariana Torres Mendoza',    'Elena Mendoza Ríos',     'Nivel 3', 'Taller B', '6-15'),
  ('11111111-0001-0001-0001-000000000010', 'Daniel Ramírez Flores',     'Claudia Flores Vega',    'Nivel 3', 'Taller C', '6-15'),
  ('11111111-0001-0001-0001-000000000011', 'Luciana Moreno Ortega',     'Diana Ortega Guerrero',  'Nivel 3', 'Taller C', '16-30'),
  ('11111111-0001-0001-0001-000000000012', 'Nicolás Flores Aguilar',    'Isabel Aguilar Fuentes', 'Nivel 3', 'Taller D', '6-15'),
  ('11111111-0001-0001-0001-000000000013', 'Valeria Jiménez Silva',     'Yolanda Silva Campos',   'Nivel 4', 'Taller A', '16-30'),
  ('11111111-0001-0001-0001-000000000014', 'Emilio Castillo Reyna',     'Fernanda Reyna Torres',  'Nivel 4', 'Taller B', '6-15'),
  ('11111111-0001-0001-0001-000000000015', 'Natalia Ortega Delgado',    'Rocío Delgado Soto',     'Nivel 4', 'Taller C', '16-30'),
  ('11111111-0001-0001-0001-000000000016', 'Andrés Gutiérrez Medina',   'Silvia Medina Paredes',  'Nivel 1', 'Taller D', '6-15'),
  ('11111111-0001-0001-0001-000000000017', 'Paula Sánchez Villanueva',  'Mónica Villanueva Ruiz', 'Nivel 2', 'Taller D', '6-15'),
  ('11111111-0001-0001-0001-000000000018', 'Felipe Reyes Contreras',    'Adriana Contreras Lara', 'Nivel 3', 'Taller A', '16-30'),
  ('11111111-0001-0001-0001-000000000019', 'Gabriela Mendoza Ibáñez',   'Verónica Ibáñez Peña',   'Nivel 4', 'Taller D', '6-15'),
  ('11111111-0001-0001-0001-000000000020', 'Ricardo Vega Guzmán',       'Beatriz Guzmán Nieto',   'Nivel 1', 'Taller C', '16-30');

-- ── PASO 4: Asignar días a cada beneficiario ──────────────────────────────────

INSERT INTO asistencias (bebe_id, dia) VALUES
  ('11111111-0001-0001-0001-000000000001', 'Lunes'),
  ('11111111-0001-0001-0001-000000000001', 'Miercoles'),
  ('11111111-0001-0001-0001-000000000002', 'Lunes'),
  ('11111111-0001-0001-0001-000000000002', 'Miercoles'),
  ('11111111-0001-0001-0001-000000000003', 'Martes'),
  ('11111111-0001-0001-0001-000000000003', 'Jueves'),
  ('11111111-0001-0001-0001-000000000004', 'Martes'),
  ('11111111-0001-0001-0001-000000000004', 'Jueves'),
  ('11111111-0001-0001-0001-000000000005', 'Lunes'),
  ('11111111-0001-0001-0001-000000000005', 'Miercoles'),
  ('11111111-0001-0001-0001-000000000006', 'Martes'),
  ('11111111-0001-0001-0001-000000000006', 'Jueves'),
  ('11111111-0001-0001-0001-000000000007', 'Lunes'),
  ('11111111-0001-0001-0001-000000000007', 'Miercoles'),
  ('11111111-0001-0001-0001-000000000007', 'Viernes'),
  ('11111111-0001-0001-0001-000000000008', 'Martes'),
  ('11111111-0001-0001-0001-000000000008', 'Jueves'),
  ('11111111-0001-0001-0001-000000000009', 'Lunes'),
  ('11111111-0001-0001-0001-000000000009', 'Miercoles'),
  ('11111111-0001-0001-0001-000000000010', 'Martes'),
  ('11111111-0001-0001-0001-000000000010', 'Jueves'),
  ('11111111-0001-0001-0001-000000000011', 'Lunes'),
  ('11111111-0001-0001-0001-000000000011', 'Viernes'),
  ('11111111-0001-0001-0001-000000000012', 'Martes'),
  ('11111111-0001-0001-0001-000000000012', 'Jueves'),
  ('11111111-0001-0001-0001-000000000013', 'Lunes'),
  ('11111111-0001-0001-0001-000000000013', 'Miercoles'),
  ('11111111-0001-0001-0001-000000000014', 'Martes'),
  ('11111111-0001-0001-0001-000000000014', 'Viernes'),
  ('11111111-0001-0001-0001-000000000015', 'Lunes'),
  ('11111111-0001-0001-0001-000000000015', 'Jueves'),
  ('11111111-0001-0001-0001-000000000016', 'Miercoles'),
  ('11111111-0001-0001-0001-000000000016', 'Viernes'),
  ('11111111-0001-0001-0001-000000000017', 'Lunes'),
  ('11111111-0001-0001-0001-000000000017', 'Martes'),
  ('11111111-0001-0001-0001-000000000018', 'Miercoles'),
  ('11111111-0001-0001-0001-000000000018', 'Jueves'),
  ('11111111-0001-0001-0001-000000000019', 'Martes'),
  ('11111111-0001-0001-0001-000000000019', 'Viernes'),
  ('11111111-0001-0001-0001-000000000020', 'Lunes'),
  ('11111111-0001-0001-0001-000000000020', 'Miercoles');

-- ── PASO 5: Insertar registros históricos ficticios (2 semanas) ───────────────

INSERT INTO registros_asistencia
  (nombre_bebe, nombre_madre, fase, programa, edad, fecha, dia, asistencia, ubicacion, reporte, situacion_especifica, nota, extras, no_cidi)
VALUES
  -- Semana 1 — Lunes 2026-01-05
  ('Valentina Rojas Pérez',    'Carmen Pérez Díaz',      'Nivel 1', 'Taller A', '6-15',  '2026-01-05', 'Lunes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Samuel Gómez Torres',      'Luisa Torres Vargas',    'Nivel 1', 'Taller A', '16-30', '2026-01-05', 'Lunes', 'No', '', 'No', '', '', '', ''),
  ('Sofía López Ramírez',      'Patricia Ramírez Mora',  'Nivel 2', 'Taller A', '6-15',  '2026-01-05', 'Lunes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Alejandro Díaz Moreno',    'Gloria Moreno Salinas',  'Nivel 2', 'Taller A', '16-30', '2026-01-05', 'Lunes', 'Sí', 'Sede principal', 'Sí', 'Enfermedad', 'Fiebre leve', '', ''),
  ('Camila Vargas Castillo',   'Rosa Castillo Reyes',    'Nivel 2', 'Taller B', '6-15',  '2026-01-05', 'Lunes', 'No', '', 'No', '', '', '', ''),
  ('Mariana Torres Mendoza',   'Elena Mendoza Ríos',     'Nivel 3', 'Taller B', '6-15',  '2026-01-05', 'Lunes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Luciana Moreno Ortega',    'Diana Ortega Guerrero',  'Nivel 3', 'Taller C', '16-30', '2026-01-05', 'Lunes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Valeria Jiménez Silva',    'Yolanda Silva Campos',   'Nivel 4', 'Taller A', '16-30', '2026-01-05', 'Lunes', 'No', '', 'Sí', 'Cita médica', 'Control rutinario', '', ''),
  ('Paula Sánchez Villanueva', 'Mónica Villanueva Ruiz', 'Nivel 2', 'Taller D', '6-15',  '2026-01-05', 'Lunes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Andrés Gutiérrez Medina',  'Silvia Medina Paredes',  'Nivel 1', 'Taller D', '6-15',  '2026-01-05', 'Lunes', 'Sí', 'Casa', 'No', '', '', '', ''),
  ('Gabriela Mendoza Ibáñez',  'Verónica Ibáñez Peña',   'Nivel 4', 'Taller D', '6-15',  '2026-01-05', 'Lunes', 'No', '', 'No', '', '', '', ''),
  ('Ricardo Vega Guzmán',      'Beatriz Guzmán Nieto',   'Nivel 1', 'Taller C', '16-30', '2026-01-05', 'Lunes', 'Sí', 'Sede principal', 'No', '', '', '', ''),

  -- Semana 1 — Martes 2026-01-06
  ('Isabella Martínez Cruz',   'Ana Cruz Herrera',       'Nivel 1', 'Taller B', '6-15',  '2026-01-06', 'Martes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Mateo Hernández Ruiz',     'Sandra Ruiz López',      'Nivel 1', 'Taller B', '16-30', '2026-01-06', 'Martes', 'No', '', 'No', '', '', '', ''),
  ('Alejandro Díaz Moreno',    'Gloria Moreno Salinas',  'Nivel 2', 'Taller A', '16-30', '2026-01-06', 'Martes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Sebastián Castro Jiménez', 'Marta Jiménez Suárez',   'Nivel 2', 'Taller C', '16-30', '2026-01-06', 'Martes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Daniel Ramírez Flores',    'Claudia Flores Vega',    'Nivel 3', 'Taller C', '6-15',  '2026-01-06', 'Martes', 'No', '', 'Sí', 'Emergencia familiar', 'Ausencia justificada', '', ''),
  ('Nicolás Flores Aguilar',   'Isabel Aguilar Fuentes', 'Nivel 3', 'Taller D', '6-15',  '2026-01-06', 'Martes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Emilio Castillo Reyna',    'Fernanda Reyna Torres',  'Nivel 4', 'Taller B', '6-15',  '2026-01-06', 'Martes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Felipe Reyes Contreras',   'Adriana Contreras Lara', 'Nivel 3', 'Taller A', '16-30', '2026-01-06', 'Martes', 'No', '', 'No', '', '', '', ''),
  ('Paula Sánchez Villanueva', 'Mónica Villanueva Ruiz', 'Nivel 2', 'Taller D', '6-15',  '2026-01-06', 'Martes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Gabriela Mendoza Ibáñez',  'Verónica Ibáñez Peña',   'Nivel 4', 'Taller D', '6-15',  '2026-01-06', 'Martes', 'Sí', 'Casa', 'No', '', '', '', ''),

  -- Semana 1 — Miércoles 2026-01-07
  ('Valentina Rojas Pérez',    'Carmen Pérez Díaz',      'Nivel 1', 'Taller A', '6-15',  '2026-01-07', 'Miercoles', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Samuel Gómez Torres',      'Luisa Torres Vargas',    'Nivel 1', 'Taller A', '16-30', '2026-01-07', 'Miercoles', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Sofía López Ramírez',      'Patricia Ramírez Mora',  'Nivel 2', 'Taller A', '6-15',  '2026-01-07', 'Miercoles', 'No', '', 'No', '', '', '', ''),
  ('Camila Vargas Castillo',   'Rosa Castillo Reyes',    'Nivel 2', 'Taller B', '6-15',  '2026-01-07', 'Miercoles', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Mariana Torres Mendoza',   'Elena Mendoza Ríos',     'Nivel 3', 'Taller B', '6-15',  '2026-01-07', 'Miercoles', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Luciana Moreno Ortega',    'Diana Ortega Guerrero',  'Nivel 3', 'Taller C', '16-30', '2026-01-07', 'Miercoles', 'No', '', 'No', '', '', '', ''),
  ('Andrés Gutiérrez Medina',  'Silvia Medina Paredes',  'Nivel 1', 'Taller D', '6-15',  '2026-01-07', 'Miercoles', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Valeria Jiménez Silva',    'Yolanda Silva Campos',   'Nivel 4', 'Taller A', '16-30', '2026-01-07', 'Miercoles', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Felipe Reyes Contreras',   'Adriana Contreras Lara', 'Nivel 3', 'Taller A', '16-30', '2026-01-07', 'Miercoles', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Ricardo Vega Guzmán',      'Beatriz Guzmán Nieto',   'Nivel 1', 'Taller C', '16-30', '2026-01-07', 'Miercoles', 'No', '', 'No', '', '', '', ''),

  -- Semana 1 — Jueves 2026-01-08
  ('Isabella Martínez Cruz',   'Ana Cruz Herrera',       'Nivel 1', 'Taller B', '6-15',  '2026-01-08', 'Jueves', 'No', '', 'No', '', '', '', ''),
  ('Mateo Hernández Ruiz',     'Sandra Ruiz López',      'Nivel 1', 'Taller B', '16-30', '2026-01-08', 'Jueves', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Alejandro Díaz Moreno',    'Gloria Moreno Salinas',  'Nivel 2', 'Taller A', '16-30', '2026-01-08', 'Jueves', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Sebastián Castro Jiménez', 'Marta Jiménez Suárez',   'Nivel 2', 'Taller C', '16-30', '2026-01-08', 'Jueves', 'No', '', 'Sí', 'Permiso', 'Permiso personal', '', ''),
  ('Daniel Ramírez Flores',    'Claudia Flores Vega',    'Nivel 3', 'Taller C', '6-15',  '2026-01-08', 'Jueves', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Nicolás Flores Aguilar',   'Isabel Aguilar Fuentes', 'Nivel 3', 'Taller D', '6-15',  '2026-01-08', 'Jueves', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Natalia Ortega Delgado',   'Rocío Delgado Soto',     'Nivel 4', 'Taller C', '16-30', '2026-01-08', 'Jueves', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Andrés Gutiérrez Medina',  'Silvia Medina Paredes',  'Nivel 1', 'Taller D', '6-15',  '2026-01-08', 'Jueves', 'No', '', 'No', '', '', '', ''),
  ('Felipe Reyes Contreras',   'Adriana Contreras Lara', 'Nivel 3', 'Taller A', '16-30', '2026-01-08', 'Jueves', 'Sí', 'Casa', 'No', '', '', '', ''),

  -- Semana 1 — Viernes 2026-01-09
  ('Camila Vargas Castillo',   'Rosa Castillo Reyes',    'Nivel 2', 'Taller B', '6-15',  '2026-01-09', 'Viernes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Luciana Moreno Ortega',    'Diana Ortega Guerrero',  'Nivel 3', 'Taller C', '16-30', '2026-01-09', 'Viernes', 'No', '', 'No', '', '', '', ''),
  ('Emilio Castillo Reyna',    'Fernanda Reyna Torres',  'Nivel 4', 'Taller B', '6-15',  '2026-01-09', 'Viernes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Natalia Ortega Delgado',   'Rocío Delgado Soto',     'Nivel 4', 'Taller C', '16-30', '2026-01-09', 'Viernes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Andrés Gutiérrez Medina',  'Silvia Medina Paredes',  'Nivel 1', 'Taller D', '6-15',  '2026-01-09', 'Viernes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Gabriela Mendoza Ibáñez',  'Verónica Ibáñez Peña',   'Nivel 4', 'Taller D', '6-15',  '2026-01-09', 'Viernes', 'No', '', 'No', '', '', '', ''),

  -- Semana 2 — Lunes 2026-01-12
  ('Valentina Rojas Pérez',    'Carmen Pérez Díaz',      'Nivel 1', 'Taller A', '6-15',  '2026-01-12', 'Lunes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Samuel Gómez Torres',      'Luisa Torres Vargas',    'Nivel 1', 'Taller A', '16-30', '2026-01-12', 'Lunes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Sofía López Ramírez',      'Patricia Ramírez Mora',  'Nivel 2', 'Taller A', '6-15',  '2026-01-12', 'Lunes', 'Sí', 'Casa', 'No', '', '', '', ''),
  ('Alejandro Díaz Moreno',    'Gloria Moreno Salinas',  'Nivel 2', 'Taller A', '16-30', '2026-01-12', 'Lunes', 'No', '', 'No', '', '', '', ''),
  ('Camila Vargas Castillo',   'Rosa Castillo Reyes',    'Nivel 2', 'Taller B', '6-15',  '2026-01-12', 'Lunes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Mariana Torres Mendoza',   'Elena Mendoza Ríos',     'Nivel 3', 'Taller B', '6-15',  '2026-01-12', 'Lunes', 'No', '', 'Sí', 'Enfermedad', 'Gripa', '', ''),
  ('Luciana Moreno Ortega',    'Diana Ortega Guerrero',  'Nivel 3', 'Taller C', '16-30', '2026-01-12', 'Lunes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Valeria Jiménez Silva',    'Yolanda Silva Campos',   'Nivel 4', 'Taller A', '16-30', '2026-01-12', 'Lunes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Paula Sánchez Villanueva', 'Mónica Villanueva Ruiz', 'Nivel 2', 'Taller D', '6-15',  '2026-01-12', 'Lunes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Andrés Gutiérrez Medina',  'Silvia Medina Paredes',  'Nivel 1', 'Taller D', '6-15',  '2026-01-12', 'Lunes', 'No', '', 'No', '', '', '', ''),
  ('Gabriela Mendoza Ibáñez',  'Verónica Ibáñez Peña',   'Nivel 4', 'Taller D', '6-15',  '2026-01-12', 'Lunes', 'Sí', 'Sede principal', 'No', '', '', '', ''),
  ('Ricardo Vega Guzmán',      'Beatriz Guzmán Nieto',   'Nivel 1', 'Taller C', '16-30', '2026-01-12', 'Lunes', 'Sí', 'Sede principal', 'No', '', '', '', '');

-- ── PASO 6: Usuarios de demo ──────────────────────────────────────────────────
-- IMPORTANTE: Primero crea los usuarios en Supabase Auth:
--   admin@demo.com       / Demo1234!
--   coordinadora@demo.com / Demo1234!
--   profesora@demo.com   / Demo1234!
-- Luego reemplaza los UUIDs de abajo con los generados por Supabase Auth
-- y ejecuta este INSERT.

-- INSERT INTO usuarios (id, email, nombre, rol) VALUES
--   ('UUID-DEL-ADMIN',        'admin@demo.com',        'Admin Demo',        'admin'),
--   ('UUID-DE-COORDINADORA',  'coordinadora@demo.com', 'Coordinadora Demo', 'coordinadora'),
--   ('UUID-DE-PROFESORA',     'profesora@demo.com',    'Profesora Demo',    'profesora');