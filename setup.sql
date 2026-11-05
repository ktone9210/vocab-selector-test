-- Supabase > SQL Editor で一度だけ実行します。
create table if not exists public.word_decisions (
  user_id uuid not null references auth.users(id) on delete cascade,
  word text not null,
  status text not null check (status in ('keep','skip','hold','new')),
  updated_at timestamptz not null default now(),
  primary key (user_id, word)
);
alter table public.word_decisions enable row level security;
revoke all on public.word_decisions from anon;
grant select, insert, update, delete on public.word_decisions to authenticated;
drop policy if exists "select own decisions" on public.word_decisions;
drop policy if exists "insert own decisions" on public.word_decisions;
drop policy if exists "update own decisions" on public.word_decisions;
drop policy if exists "delete own decisions" on public.word_decisions;
create policy "select own decisions" on public.word_decisions for select to authenticated using ((select auth.uid()) = user_id);
create policy "insert own decisions" on public.word_decisions for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "update own decisions" on public.word_decisions for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "delete own decisions" on public.word_decisions for delete to authenticated using ((select auth.uid()) = user_id);
