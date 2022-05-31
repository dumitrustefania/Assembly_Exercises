# Task 1 - Noduri (25p)

Sursee dorește să găseasca drumul până în Rectorat ca să vadă si ea vestitul OZN.
Ea știe prin ce clădiri trebuie să treacă dar lista a fost amestecată.
Ajutați-o să ordoneze lista prin conectarea elementelor care inițial erau alăturate.

Trebuie să implementați funcția cu semnătura `struct node* sort(int n, struct node* node);` din fișierul task1.asm, care “leagă” nodurile din listă în ordine crescătoare.
Funcția primește numărul de noduri și adresa vectorului și întoarce adresa primului nod din lista rezultată.

Structura unui nod este:
```
struct node {
    int val;
    struct node* next;
};
```
și, inițial, câmpul `next` este setat la `NULL`.

Antetul funcției este:
```
struct node* sort(int n, struct node* node); 
```

Semnificația argumentelor este:

* *n* numărul de noduri
* *node* adresa vectorului ce trebuie sortat

Funcția returneaza adresa primului nod din lista ordonată.

## Exemplu
```
Inițial:

| Adresă    | Valoare   | Next      |
| --------- | --------- | --------- |
| 0x32      | 2         | NULL      |
| 0x3A      | 1         | NULL      |
| 0x42      | 3         | NULL      |

Apelul funcției `sort` întoarce `0x3A` (adresa nodului cu valoarea 1) și vectorul va arăta astfel:

| Adresă    | Valoare   | Next      |
| --------- | --------- | --------- |
| 0x32      | 2         | 0x42      |
| 0x3A      | 1         | 0x32      |
| 0x42      | 3         | NULL      |
```

## Precizări:
- n >= 1
- secvența conține numere consecutive distincte începand cu 1 (ex: 1 2 3 ...)
- structura vectorulului NU trebuie modificată (interschimbarea nodurilor este interzisă)
- sortarea trebuie facută in-place
- este permisă folosirea unor structuri auxiliare, atâta timp cât, nodurile listei rezultate sunt cele din vectorul inițial
- NU este permisă folosirea funcției `qsort` din libc
