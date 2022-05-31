## Task 2 - Mașina cu Stivă 25p

Mushu trebuie să ajungă la Leu, dar este împiedicat de portarul cel rău de la Precis. 
Acesta îi pune în față o [Masina cu stiva](https://en.wikipedia.org/wiki/Stack_machine), adică o mașina care știe să folosească doar stiva, prin instrucțiuni de tip push și pop, pentru a lucra cu memoria.
Provocarea lui Mushu este să implementeze 2 funcții pe această mașină:

### CMMMC

Prima functie este `int cmmmc(int a, int b)`, care calculeaza cel mai mic multiplu comun a 2 numere, date ca parametru.
Se garanteaza ca rezultatul inmultirii lui a si b incape pe 4 bytes.

Antetul funcției este:
```
int cmmmc(int a, int b);
```

Cele două argumente sunt numerele cărora trebuie să le aflăm cel mai mare divizor comun.

Funcția returneaza cel mai mare divizor comun al celor două numere.

### Paranteze

A doua functie este `int par(int str_length, char *str)`, care verifica daca o secventa de paranteze este corecta.
Aceasta primeste un sir catre contine doar paranteze rotunde si lungimea sirului, si intoarce 1, daca secventa e corecta, sau 0, daca secventa e gresita.

Antetul funcției este:
```
int par(int str_length, char *str); 
```

Semnificația argumentelor este:
  * **str_length** numărul de noduri
  * **str** adresa șirului de paranteze

Funcția returnează 0 daca parantezarea nu este corectă și 1 daca parantezarea e corectă.

#### Exemplu

Pentru secventa `((()())(()))`, rezultatul va fi 1
Pentru secventa `(())((`, rezultatul va fi 0

#### Atentie

Nu aveti voie sa folositi intructiunile din familia mov (mov, cmov, stos, lods, etc), leave si enter.
