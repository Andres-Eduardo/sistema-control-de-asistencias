// constants.js — Etiquetas parametrizables del sistema
// Cambia estos valores para adaptar el sistema a cualquier organización
// ─────────────────────────────────────────────────────────────────────

const APP_CONFIG = {
  // ── Nombre de la organización ──────────────────────────────────────
  ORGANIZACION: "Fundación Esperanza",
  SISTEMA: "Sistema de Control de Asistencia",

  // ── Etiquetas de los campos principales ───────────────────────────
  BENEFICIARIO: "Beneficiario", // antes: "Bebé"
  BENEFICIARIO_PLURAL: "Beneficiarios",
  ACUDIENTE: "Acudiente", // antes: "Madre"
  FASE: "Nivel", // antes: "Fase"
  PROGRAMA: "Taller", // antes: "Programa"
  EDAD: "Edad", // antes: "Edad (meses)"

  // ── Opciones de Fase ───────────────────────────────────────────────
  FASES: ["Nivel 1", "Nivel 2", "Nivel 3", "Nivel 4", "Otro"],

  // ── Opciones de Programa ───────────────────────────────────────────
  PROGRAMAS: ["Taller A", "Taller B", "Taller C", "Taller D", "Otro"],

  // ── Tipos de registro ──────────────────────────────────────────────
  TIPO_NORMAL: "Normal",
  TIPO_EXTRA: "Tipo A", // antes: "Extras"
  TIPO_NOCIDI: "Tipo B", // antes: "No CIDI"

  // ── Situaciones especiales ─────────────────────────────────────────
  SITUACIONES: [
    "Enfermedad",
    "Cita médica",
    "Permiso",
    "Emergencia familiar",
    "Otro",
  ],

  // ── Ubicaciones ────────────────────────────────────────────────────
  UBICACIONES: ["Sede principal", "Casa", "Otro"],

  // ── Roles del sistema ──────────────────────────────────────────────
  ROLES: {
    admin: "Administrador",
    coordinadora: "Coordinadora",
    profesora: "Instructora",
  },

  // ── Días de la semana ──────────────────────────────────────────────
  DIAS: ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes"],
};
