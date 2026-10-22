-- Lista de presença do Lanche da Sexta.
-- Cole tudo no SQL Editor do Supabase e clique em Run (pode rodar de novo sem problema).

create table if not exists public.presencas (
  data          date        not null,
  pessoa        text        not null,
  status        text        not null,
  atualizado_em timestamptz not null default now(),
  primary key (data, pessoa),
  constraint presencas_status check (status in ('confirmado', 'ausente')),
  constraint presencas_pessoa check (char_length(pessoa) between 1 and 40),
  constraint presencas_sexta  check (extract(isodow from data) = 5)
);

-- Guarda a hora da última mudança.
create or replace function public.presencas_atualizado_em()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.atualizado_em := now();
  return new;
end;
$$;

drop trigger if exists presencas_atualizado_em on public.presencas;
create trigger presencas_atualizado_em
  before update on public.presencas
  for each row execute function public.presencas_atualizado_em();

-- A lista de uma sexta só aceita mudanças de terça a quinta daquela semana
-- (horário de Brasília). O site usa a mesma regra para liberar os botões.
create or replace function public.presenca_aberta(d date)
returns boolean
language sql
stable
set search_path = ''
as $$
  select extract(isodow from d) = 5
     and (now() at time zone 'America/Sao_Paulo')::date between d - 3 and d - 1;
$$;

grant execute on function public.presenca_aberta(date) to anon;

-- Regras de acesso para o site (chave pública, sem login):
-- todo mundo lê; marcar, mudar ou desmarcar só dentro da janela acima.
alter table public.presencas enable row level security;

drop policy if exists "site le presencas" on public.presencas;
create policy "site le presencas" on public.presencas
  for select to anon using (true);

drop policy if exists "site marca presenca" on public.presencas;
create policy "site marca presenca" on public.presencas
  for insert to anon
  with check (public.presenca_aberta(data));

drop policy if exists "site muda presenca" on public.presencas;
create policy "site muda presenca" on public.presencas
  for update to anon
  using (public.presenca_aberta(data))
  with check (public.presenca_aberta(data));

drop policy if exists "site desmarca presenca" on public.presencas;
create policy "site desmarca presenca" on public.presencas
  for delete to anon
  using (public.presenca_aberta(data));

grant select, insert, update, delete on public.presencas to anon;
