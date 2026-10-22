[README.md](https://github.com/user-attachments/files/33825313/README.md)
# Lanche da Sexta

Página que mostra quem traz o lanche da equipe na próxima sexta, a data e o rodízio.
A próxima pessoa e a próxima data são calculadas pela data do dia, então a página
vira sozinha toda semana.

## Arquivos

- `index.html`: a página (não precisa mexer).
- `dados.js`: a escala, o rodízio, as ideias de lanche e a configuração da lista de presença. **É só este que você edita.**
- `supabase.sql`: cria a tabela da lista de presença no Supabase (usado uma vez só).

## Publicar no GitHub Pages (uma vez só)

1. No repositório do GitHub, clique em **Add file → Upload files**, arraste
   `index.html`, `dados.js` e `README.md` e clique em **Commit changes**.
2. Vá em **Settings → Pages**.
3. Em **Build and deployment → Source**, escolha **Deploy from a branch**.
4. Em **Branch**, escolha `main` e a pasta `/ (root)` e clique em **Save**.
5. Depois de 1 ou 2 minutos, o link aparece no topo dessa mesma tela, no formato
   `https://SEU-USUARIO.github.io/NOME-DO-REPOSITORIO/`. É esse link que você manda para o pessoal.

> Num repositório público, qualquer pessoa com o link vê a página (e os nomes da escala).

## Mudar a escala

Abra `dados.js` no GitHub, clique no lápis (**Edit this file**), faça a mudança e
clique em **Commit changes**. A página atualiza em cerca de 1 minuto.

Se algo ficar errado no arquivo (data que não é sexta, vírgula faltando etc.), a
página mostra um aviso vermelho dizendo o que corrigir.

### Exemplos

**Troca entre duas pessoas**: troque os nomes nas duas sextas.

```js
{ data: "2026-10-16", pessoas: ["Helen"] },
{ data: "2026-10-23", pessoas: ["Diego"] },
```

**Sexta sem lanche** (feriado, folga):

```js
{ data: "2026-11-20", semLanche: true, motivo: "Consciência Negra" },
```

**Duas pessoas no mesmo dia, com observação**:

```js
{ data: "2026-11-06", pessoas: ["Janela", "Renato"], obs: "pizza" },
```

**Pessoa nova ou que saiu**: mude a lista `ordem` dentro de `rodizio`.

### Como o rodízio funciona

- As sextas listadas em `escala` valem como estão.
- A partir da data `rodizio.aPartirDe`, toda sexta que **não** está na lista recebe
  a próxima pessoa de `rodizio.ordem`, começando por `rodizio.comecaCom`.
  Essas sextas aparecem com a etiqueta "pelo rodízio".
- Uma sexta com `semLanche: true` depois dessa data empurra a fila uma semana.
- Uma troca entre duas pessoas não muda a ordem de ninguém.

## Lista de presença ("Quem vai estar")

Cada pessoa marca **Confirmado** ou **Ausente** para o próximo lanche. Clicar de
novo no mesmo botão desmarca. A lista vira sozinha para a sexta seguinte, junto
com o resto da página. As respostas ficam guardadas num banco gratuito do Supabase.

- A lista começa fechada (retraída). Clique nela para abrir; cada pessoa tem a
  sua escolha de aberta ou fechada lembrada no próprio aparelho.
- Os botões só funcionam **de terça a quinta** da semana do lanche. Fora disso,
  dá para ver as respostas, mas não mudar. O banco aplica a mesma regra.
- Quem traz o lanche já aparece como **Confirmado**, mas pode mudar para Ausente.

### Ligar a lista (uma vez só)

1. Crie uma conta em https://supabase.com e clique em **New project**. O plano
   Free basta. Em região, escolha **South America (São Paulo)**.
2. Com o projeto aberto, vá em **SQL Editor**, clique em **New query**, cole todo
   o conteúdo de `supabase.sql` e clique em **Run**. Deve aparecer
   "Success. No rows returned".
3. Pegue o endereço e a chave pública: botão **Connect** no topo do painel, ou
   **Project Settings → API Keys**.
   - **Project URL**: algo como `https://abcdefghijkl.supabase.co`
   - **Publishable key**: começa com `sb_publishable_`. Em projetos antigos,
     use a **anon public**, que começa com `eyJ`.
4. No `dados.js`, preencha o bloco `presenca` e clique em **Commit changes**:

   ```js
   presenca: {
     supabaseUrl: "https://abcdefghijkl.supabase.co",
     supabaseChave: "sb_publishable_...",
   },
   ```

> **Nunca** coloque no `dados.js` a chave **secret** / **service_role**. Ela dá
> acesso total ao banco e o repositório é público. Se isso acontecer por engano,
> a página mostra um aviso; nesse caso, gere uma chave nova no Supabase.

### Quem aparece na lista

Por padrão aparecem as pessoas do rodízio (`rodizio.ordem`). Para incluir mais
gente, como quem não traz lanche mas participa, preencha `participantes`:

```js
participantes: ["Janela", "Renato", "Kevin", "Ricardo"],
```

### Bom saber

- Não tem login: qualquer pessoa com o link consegue marcar qualquer nome. Para
  uma lista de lanche isso costuma bastar. A chave pública fica visível no site,
  e isso é normal no Supabase: o que ela pode fazer é limitado pelas regras do
  `supabase.sql`.
- Para ver ou apagar respostas, use o **Table Editor** do Supabase, tabela `presencas`.
- No plano Free, o Supabase pausa projetos que ficam uma semana sem nenhum uso.
  Se a lista parar de funcionar depois de um tempo parado, entre no painel do
  Supabase e clique em **Restore project**.
