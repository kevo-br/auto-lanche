-- Lista de presença do Lanche da Sexta.
-- Cole tudo no SQL Editor do Supabase e clique em Run (pode rodar de novo sem problema).
-- Tudo aqui começa com "lanche_", para conviver com tabelas de outros sites no mesmo projeto.

create table if not exists public.lanche_presencas (
  data          date        not null,
  pessoa        text        not null,
  status        text        not null,
  atualizado_em timestamptz not null default now(),
  primary key (data, pessoa),
  constraint lanche_presencas_status   check (status in ('confirmado', 'ausente')),
  constraint lanche_presencas_pessoa   check (char_length(pessoa) between 1 and 40),
  -- O lanche é na sexta, mas pode ir para outro dia útil da semana quando a sexta é feriado.
  constraint lanche_presencas_dia_util check (extract(isodow from data) between 1 and 5)
);

-- Guarda a hora da última mudança.
create or replace function public.lanche_presencas_atualizado_em()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.atualizado_em := now();
  return new;
end;
$$;

drop trigger if exists lanche_presencas_atualizado_em on public.lanche_presencas;
create trigger lanche_presencas_atualizado_em
  before update on public.lanche_presencas
  for each row execute function public.lanche_presencas_atualizado_em();

-- A lista de um lanche só aceita mudanças da terça daquela semana até a véspera
-- (horário de Brasília): terça a quinta para sexta, terça e quarta se o lanche for na quinta.
-- O site usa a mesma regra para liberar os botões.
create or replace function public.lanche_presenca_aberta(d date)
returns boolean
language sql
stable
set search_path = ''
as $$
  select extract(isodow from d) between 1 and 5
     and (now() at time zone 'America/Sao_Paulo')::date
         between least(d - (extract(isodow from d)::int - 2), d - 1) and d - 1;
$$;

grant execute on function public.lanche_presenca_aberta(date) to anon;

-- Regras de acesso para o site (chave pública, sem login):
-- todo mundo lê; marcar, mudar ou desmarcar só dentro da janela acima.
-- Valem só para esta tabela; as tabelas de outros sites não são afetadas.
alter table public.lanche_presencas enable row level security;

drop policy if exists "lanche le presencas" on public.lanche_presencas;
create policy "lanche le presencas" on public.lanche_presencas
  for select to anon using (true);

drop policy if exists "lanche marca presenca" on public.lanche_presencas;
create policy "lanche marca presenca" on public.lanche_presencas
  for insert to anon
  with check (public.lanche_presenca_aberta(data));

drop policy if exists "lanche muda presenca" on public.lanche_presencas;
create policy "lanche muda presenca" on public.lanche_presencas
  for update to anon
  using (public.lanche_presenca_aberta(data))
  with check (public.lanche_presenca_aberta(data));

drop policy if exists "lanche desmarca presenca" on public.lanche_presencas;
create policy "lanche desmarca presenca" on public.lanche_presencas
  for delete to anon
  using (public.lanche_presenca_aberta(data));

grant select, insert, update, delete on public.lanche_presencas to anon;
