# Parcours Elixir — projet `learning`

**Pour :** Ibrahim · apprentissage Elixir en projet direct  
**Projet :** `ELIXIR-LEARNING/MODULE/learning`  
**Objectif final :** lire et modifier `rema-backend` (Ash + OTP) sans dépendre de l’IA

---

## Déjà fait (ne pas refaire)

- [x] Modules + fonctions (`defmodule`, `def`, `defp`)
- [x] Arguments par défaut (`\\`)
- [x] Guards (`when`, `is_integer`)
- [x] Pattern matching sur clauses de fonctions (`zero?(0)`)
- [x] `require` / `alias`
- [x] Premiers tests ExUnit

Fichiers existants : `maths.ex`, `hello.ex`, `shout.ex`, `module_guard.ex`, `default_arguments.ex`, `use_require.ex`

---

## Ordre des concepts (ne pas sauter)

### 1. Pattern matching ← **prochaine étape**

Le cœur d’Elixir. Tu l’as déjà un peu (`zero?(0)`), il faut le maîtriser partout.

**À apprendre**
- `=` n’est pas une affectation
- tuples `{:ok, x}` / `{:error, reason}`
- maps `%{name: n} = user`
- clauses de fonctions multiples

**Exercice**
- Fichier : `lib/parse_result.ex`
- Fonction `parse_result/1` qui gère `{:ok, v}` et `{:error, r}`
- Test : `test/parse_result_test.exs`

**Succès** — tu écris sans regarder la doc :
```elixir
{:ok, value} = {:ok, 42}
%{phone: phone} = %{phone: "0700000000", balance: 0}
```

---

### 2. Types + maps

**À apprendre**
- atoms `:ok`, `:error`, `:success`
- maps `%{phone: "...", balance: 0}` ← partout dans REMA / Ash
- structs (après les maps)

**Exercice**
- Fichier : `lib/account.ex`
- Map `account` + `credit/2`, `debit/2` qui retournent une **nouvelle** map (immutabilité)
- Test : `test/account_test.exs`

**Succès** — `debit` refuse un solde insuffisant avec `{:error, :insufficient_funds}`.

---

### 3. Listes + `Enum` + pipe `|>`

**À apprendre**
- `[1, 2, 3]`, head/tail `[h | t]`
- `Enum.map`, `filter`, `reduce`, `sum`
- `|>` partout

**Exercice**
- Fichier : `lib/transactions.ex`
- Liste de transactions → total des montants avec status `:success` uniquement
- Test : `test/transactions_test.exs`

**Succès** — tu chaînes 3 opérations avec `|>` sans variable intermédiaire.

---

### 4. Contrôle de flux

Dans cet ordre :
1. `case`
2. `cond`
3. `if` (rare)
4. **`with`** ← critique pour le backend (`{:ok, _}` en chaîne)

**Exercice**
- Fichier : `lib/transfer.ex`
- `transfer(from, to, amount)` avec `with` (solde suffisant, etc.)
- Test : `test/transfer_test.exs`

**Succès** — un seul `with` gère crédit + débit + erreurs propres.

---

### 5. Tests ExUnit + Mix (renforcer)

Systematise ce que tu as déjà :
- un test par comportement
- `mix test`
- `assert` / `refute` / `assert_raise`

**Exercice**
- Pour chaque module des étapes 1–4 : couverture minimale (cas OK + cas erreur)

---

### 6. OTP (léger)

**À apprendre**
- processus
- `GenServer` (état)
- `Supervisor` / `Application`
- optionnel : `mix new learning_otp --sup` si tu veux un dossier `config/`

**Exercice**
- GenServer compteur de solde (ou wallet en mémoire)
- Test avec `start_supervised!/1`

**Succès** — tu expliques ce que fait `RemaBackend.Application` (supervisor + children).

---

### 7. Ecto (avant Ash)

**À apprendre**
- Repo, schema, changeset, migration
- CRUD simple Postgres

**Exercice**
- Mini-projet séparé ou dossier dédié : table `accounts`, create/read/update balance

**Succès** — tu crées une migration et un changeset sans copier-coller.

---

### 8. Ash (ton vrai backend)

**À apprendre**
- Resource, Domain, attributes, actions
- Relire `Account` / `Transaction` dans `rema-backend` **en comprenant** chaque ligne

**Exercice**
- Ouvre `rema-backend` (branche `develop`)
- Ajoute un attribut ou une action simple sur une resource existante
- `mix test` / `mix precommit`

---

### 9. Phoenix / JSON API (plus tard)

Quand Ash est clair : endpoints, plugs, auth.  
Pas prioritaire tant que 1 → 8 ne sont pas solides.

---

## Ce que tu ne fais **pas** maintenant

| Trop tôt | Pourquoi |
|----------|----------|
| Ash / Phoenix en premier | trop de magie sans bases |
| Rustler / NIF | après OTP + Ecto |
| LiveView | pas prioritaire pour REMA mobile API |
| Tout le livre d’un coup | avance concept par concept |

---

## Rythme sugeré

| Semaine | Focus | Fichiers cibles |
|---------|--------|-----------------|
| **Cette semaine** | Pattern matching + maps | `parse_result.ex`, `account.ex` |
| **Semaine +1** | Enum + `|>` + `case`/`with` | `transactions.ex`, `transfer.ex` |
| **Semaine +2** | Tests solides + GenServer | OTP mini |
| **Semaine +3** | Ecto mini-projet | schema + migration |
| **Ensuite** | Ash sur `rema-backend` | lire + modifier une resource |

---

## Format d’une session (2 h)

| Bloc | Durée | Action |
|------|-------|--------|
| A | 20 min | Lire le concept (guide officiel) |
| B | 20 min | Micro-exo dans `iex` |
| C | 90 min | Coder le fichier + test |
| D | 20 min | Refaire de mémoire sans regarder |
| E | 10 min | 3 lignes de notes (compris / bloqué / demain) |

**Règle :** sessions d’apprentissage **sans IA** pour coder. IA OK le soir pour expliquer un blocage précis.

---

## Ressources (par ordre)

1. [Getting Started — elixir-lang.org](https://elixir-lang.org/getting-started/introduction.html)
2. [Exercism — track Elixir](https://exercism.org/tracks/elixir)
3. [Elixir School](https://elixirschool.com)
4. Livre : *Programming Elixir* (Dave Thomas) — chapitres ciblés, pas tout d’un coup
5. Ash : [ash-hq.org](https://ash-hq.org) — seulement à l’étape 8

---

## Règle d’or

Chaque concept → **1 fichier dans `lib/`** + **1 test dans `test/`**.

Quand tu lis du code REMA le soir, tu ne cherches que ce que tu as déjà appris dans ce parcours.

---

## Checklist globale

- [ ] 1. Pattern matching
- [ ] 2. Maps + atoms (+ structs)
- [ ] 3. Listes + Enum + `|>`
- [ ] 4. `case` / `cond` / `with`
- [ ] 5. Tests ExUnit solides
- [ ] 6. OTP (GenServer + Supervisor)
- [ ] 7. Ecto
- [ ] 8. Ash (rema-backend)
- [ ] 9. Phoenix / JSON API

Coche au fur et à mesure. Ne passe à l’étape suivante que si l’exercice de succès est vert (`mix test`).
