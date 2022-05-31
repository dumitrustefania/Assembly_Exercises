# Task 3 Sortare de cuvinte 25p

Luna a mers împreună cu Sursee până în Rectorat dar acum trebuie sa ajungă îm Regie.
Luna are de completat un rebus folosind cuvintele unui text și vă roagă să o ajutați prin a sorta cuvintele în funcție de lungime ca să îi fie mai ușor.

Pentru acest task veți avea de separat un text în cuvinte după niște delimitatori și, după aceea, să sortați aceste cuvinte folosind functia qsort.
Sortarea se va face întâi după lungimea cuvintelor și în cazul egalității se va sorta lexicografic.

Va trebui să implementați 2 functii cu semnaturile `void get_words(char *s, char **words, int number_of_words);` si `void sort(char **words, int number_of_words, int size);` din fisierul `task3.asm`. 


Antetul primei funcții este:
```
void get_words(char *s, char **words, int number_of_words); 
```

Semnificația argumentelor este:
  * **s** textul din care extragem cuvintele
  * **words** vectorul de string-uri în care se salvează cuvintele găsite
  * **number_of_words** numărul de cuvinte

Atenție, funcția *nu* returnează nimic, cuvintele se salveaza in vectorul words!

Antetul celei de-a doua funcții este:
```
void sort(char **words, int number_of_words, int size);
```

Semnificația argumentelor este:
  * **words** vectorul de cuvinte ce trebuie sortat
  * **number_of_words** numărul de cuvinte
  * **size** dimensiunea unui cuvânt

Atenție, funcția *nu* returnează nimic, sortarea se face in-place!

## Precizări:
- lungimea textului este mai mica decat 1000;
- vectorul de cuvinte va avea maxim 100 de cuvine a 100 de caractere fiecare;
- delimitatorii pe care trebuie sa ii luati in calcul sunt: " ,.\n"
- nu aveti voie sa folositi alta metoda de sortare in afara de qsort.
In cazul in care veti folosi alta metoda punctajul pe acest task se va pierde.

## Exemplu
```
number_of_words: 9
s: "Ana are 27 de mere, si 32 de pere."
dupa apelul get_words: words = ["Ana", "are", "27", "de", "mere", "si", "32", "de", "pere"]
dupa apelul sort: words = ["27", "32", "de", "de", "si", "Ana", "are", "mere", "pere"]
```

## Hint:
- pentru mai multe informatii despre qsort puteti accesa linkul: https://man7.org/linux/man-pages/man3/qsort.3.html

