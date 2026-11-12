-- VolleyTrack: Im Supabase SQL Editor einmalig ausführen.
-- Authentication > Providers > Email: öffentliche Registrierung (Sign ups) deaktivieren.
-- Authentication > Users: eigenen Benutzer manuell hinzufügen.
create extension if not exists pgcrypto;
create table if not exists public.players (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 name text not null check (char_length(trim(name)) between 1 and 100),
 active boolean not null default true,
 created_at timestamptz not null default now()
);
create table if not exists public.trainings (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 date date not null,
 status text not null default 'offen' check (status in ('offen','durchgefuehrt','ausgefallen')),
 created_at timestamptz not null default now(),
 unique(user_id,date),
 unique(id,user_id)
);
create table if not exists public.attendance (
 training_id uuid not null,
 player_id uuid not null,
 user_id uuid not null references auth.users(id) on delete cascade,
 status text not null default 'nicht_abgestimmt' check (status in ('nicht_abgestimmt','zugesagt','abgesagt')),
 primary key(training_id,player_id),
 foreign key(training_id,user_id) references public.trainings(id,user_id) on delete cascade
);
-- Ensure attendance cannot reference another user's player, including for inserts.
alter table public.players add constraint players_id_user_unique unique(id,user_id);
alter table public.attendance add constraint attendance_player_owner_fk foreign key(player_id,user_id) references public.players(id,user_id) on delete cascade;
alter table public.players enable row level security;
alter table public.trainings enable row level security;
alter table public.attendance enable row level security;
create policy "own players" on public.players for all to authenticated using (user_id=(select auth.uid())) with check (user_id=(select auth.uid()));
create policy "own trainings" on public.trainings for all to authenticated using (user_id=(select auth.uid())) with check (user_id=(select auth.uid()));
create policy "own attendance" on public.attendance for all to authenticated using (user_id=(select auth.uid())) with check (user_id=(select auth.uid()));
