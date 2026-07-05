-- DuckDrop Supabase setup
-- Run this in the Supabase SQL editor, then copy your project URL and anon key into index.html.

create extension if not exists pgcrypto;

create table if not exists ducks (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text,
  hidden_by text not null,
  hidden_location text,
  created_at timestamptz default now()
);

create table if not exists findings (
  id uuid primary key default gen_random_uuid(),
  duck_id uuid references ducks(id) on delete cascade,
  finder_name text not null,
  location text,
  photo_url text,
  found_at timestamptz default now()
);

alter table ducks enable row level security;
alter table findings enable row level security;

drop policy if exists "Public can read ducks" on ducks;
create policy "Public can read ducks"
on ducks for select
to anon
using (true);

drop policy if exists "Public can add ducks" on ducks;
create policy "Public can add ducks"
on ducks for insert
to anon
with check (true);

drop policy if exists "Public can read findings" on findings;
create policy "Public can read findings"
on findings for select
to anon
using (true);

drop policy if exists "Public can add findings" on findings;
create policy "Public can add findings"
on findings for insert
to anon
with check (true);

create index if not exists findings_duck_id_found_at_idx on findings (duck_id, found_at desc);
create index if not exists findings_finder_name_idx on findings (finder_name);

-- Optional photo uploads. Creates a public bucket named duck-photos.
insert into storage.buckets (id, name, public)
values ('duck-photos', 'duck-photos', true)
on conflict (id) do update set public = true;

drop policy if exists "Public can view duck photos" on storage.objects;
create policy "Public can view duck photos"
on storage.objects for select
to anon
using (bucket_id = 'duck-photos');

drop policy if exists "Public can upload duck photos" on storage.objects;
create policy "Public can upload duck photos"
on storage.objects for insert
to anon
with check (bucket_id = 'duck-photos');

