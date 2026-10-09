// =====================================================================
//  ESCALA DO LANCHE DA SEXTA
//  Edite este arquivo para mudar a escala. O site atualiza sozinho
//  cerca de 1 minuto depois de salvar (Commit changes) no GitHub.
//
//  Regras rápidas:
//  - Datas sempre no formato "AAAA-MM-DD" e sempre numa sexta-feira.
//  - Nomes entre aspas, separados por vírgula: ["Janela", "Renato"]
//  - Cada linha termina com vírgula.
// =====================================================================

window.LANCHE = {

  // Ordem do rodízio. Vale para as sextas que NÃO estão na lista "escala"
  // abaixo, a partir da data "aPartirDe", começando por "comecaCom".
  // - Pessoa nova: coloque o nome na posição em que ela entra na fila.
  // - Pessoa saiu: apague o nome daqui (o histórico dela continua).
  rodizio: {
    ordem: ["Janela", "Renato", "Kevin", "Eberton", "Ebraim", "Diego", "Helen", "Pablo"],
    aPartirDe: "2027-01-08",
    comecaCom: "Janela",
  },

  // Sextas já combinadas. Exemplos:
  //   Uma pessoa:      { data: "2026-10-16", pessoas: ["Diego"] },
  //   Duas pessoas:    { data: "2026-06-12", pessoas: ["Janela", "Renato"] },
  //   Com observação:  { data: "2026-10-16", pessoas: ["Diego"], obs: "vai trazer cuca" },
  //   Sem lanche:      { data: "2026-12-25", semLanche: true, motivo: "Natal" },
  //
  // Troca entre duas pessoas: troque os nomes nas duas sextas.
  // Uma sexta sem lanche depois de "aPartirDe" empurra o rodízio uma semana.
  escala: [
    { data: "2026-04-24", pessoas: ["Janela"] },
    { data: "2026-05-01", pessoas: ["Renato"] },
    { data: "2026-05-08", pessoas: ["Ricardo"] },
    { data: "2026-05-15", pessoas: ["Kevin"] },
    { data: "2026-05-22", pessoas: ["Ebraim"] },
    { data: "2026-05-29", pessoas: ["Eberton"] },
    { data: "2026-06-05", semLanche: true },
    { data: "2026-06-12", pessoas: ["Janela", "Renato"] },
    { data: "2026-06-19", pessoas: ["Ricardo", "Kevin"] },
    { data: "2026-06-26", pessoas: ["Ebraim", "Eberton"] },
    { data: "2026-07-03", pessoas: ["Janela", "Renato"] },
    { data: "2026-07-10", pessoas: ["Kevin"] },
    { data: "2026-07-17", pessoas: ["Eberton"] },
    { data: "2026-07-24", pessoas: ["Ricardo"] },
    { data: "2026-07-31", pessoas: ["Ebraim"] },
    { data: "2026-08-07", pessoas: ["Janela"] },
    { data: "2026-08-14", pessoas: ["Renato"] },
    { data: "2026-08-21", pessoas: ["Kevin"] },
    { data: "2026-08-28", pessoas: ["Eberton"] },
    { data: "2026-09-04", pessoas: ["Ebraim"] },
    { data: "2026-09-11", pessoas: ["Janela"] },
    { data: "2026-09-18", pessoas: ["Renato"] },
    { data: "2026-09-25", pessoas: ["Kevin"] },
    { data: "2026-10-02", pessoas: ["Eberton"] },
    { data: "2026-10-09", pessoas: ["Ebraim"] },
    { data: "2026-10-16", pessoas: ["Diego"] },
    { data: "2026-10-23", pessoas: ["Helen"] },
    { data: "2026-10-30", pessoas: ["Pablo"] },
    { data: "2026-11-06", pessoas: ["Janela"] },
    { data: "2026-11-13", pessoas: ["Renato"] },
    { data: "2026-11-20", pessoas: ["Kevin"] },
    { data: "2026-11-27", pessoas: ["Eberton"] },
    { data: "2026-12-04", pessoas: ["Ebraim"] },
    { data: "2026-12-11", pessoas: ["Diego"] },
    { data: "2026-12-18", pessoas: ["Helen"] },
    { data: "2026-12-25", semLanche: true, motivo: "Natal" },
    { data: "2027-01-01", semLanche: true, motivo: "Ano-Novo" },
  ],

  // Ideias de lanche com os valores anotados na planilha.
  ideias: [
    { nome: "Cuca", valor: "30" },
    { nome: "Pizza", valor: "27" },
    { nome: "Salgadinho", valor: "60" },
    { nome: "Bolo", valor: "20/30" },
    { nome: "Sanduíches", valor: "54" },
  ],

};
