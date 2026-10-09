# Lanche da Sexta

Página que mostra quem traz o lanche da equipe na próxima sexta, a data e o rodízio.
A próxima pessoa e a próxima data são calculadas pela data do dia, então a página
vira sozinha toda semana.

## Arquivos

- `index.html`: a página (não precisa mexer). 
- `dados.js`: a escala, o rodízio e as ideias de lanche. **É só este que você edita.**

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
