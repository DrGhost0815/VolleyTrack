# 🏐 VolleyTrack
Private Trainingsverwaltung als eigenständige Web-App: **GitHub Pages + Supabase**, ohne Google Sheets oder Apps Script.

## Status
V2-Grundversion: Anmeldung, Jahresübersicht, Trainingstermine, Status **Zugesagt / Abgesagt / Nicht abgestimmt**, Trainingsstatus **Offen / Durchgeführt / Ausgefallen**, Spielerverwaltung und Datenbankanbindung.

**Noch nicht umgesetzt:** Import historischer Google-Sheets-Daten, MV-Ferienkalender, detaillierte Statistik und automatische Terminplanung. Die Zuordnung „Zugesagt = teilgenommen“ bei durchgeführtem Training ist eine vereinfachte Annahme, keine tatsächliche Anwesenheitsmessung.

## Einrichtung
1. Kostenloses Projekt auf https://supabase.com/dashboard erstellen.
2. Im **SQL Editor** den Inhalt von `supabase/schema.sql` ausführen.
3. Unter **Authentication → Providers → Email** die öffentliche Registrierung deaktivieren.
4. Unter **Authentication → Users** den eigenen Benutzer anlegen; sichere Zugangsdaten verwenden.
5. In GitHub unter **Settings → Pages**: `Deploy from a branch`, `main`, `/(root)`, speichern.
6. Die Pages-Adresse öffnen. Beim ersten Aufruf die Supabase-**Project URL** und den **publishable/anon key** eintragen (Supabase → Project Settings → API Keys). **Niemals** einen Secret- oder service_role-Key eingeben.
7. Mit dem selbst angelegten Benutzer anmelden.

Die Projekt-URL und der öffentliche Schlüssel sind keine Geheimnisse. Der Zugriff auf Daten wird durch **Supabase Authentication und Row Level Security (RLS)** abgesichert. Für eine Ein-Personen-App die öffentliche Registrierung deaktiviert lassen. GitHub Pages ist öffentlich erreichbar, die Daten sind nach Anmeldung geschützt.

## Entwicklung
`index.html` ist eine statische Website und wird bei Änderungen auf `main` automatisch über GitHub Pages veröffentlicht. Die Daten liegen ausschließlich in Supabase, nicht im Repository. `supabase/schema.sql` muss manuell im Supabase SQL Editor ausgeführt werden.

**Migration:** Alte Einträge aus Google Sheets noch nicht automatisch übertragen. Vor der Umstellung sichern und eine geprüfte Importfunktion erstellen.
