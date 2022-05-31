# Task 4 - CPUID

Acum că pisicile au cucerit toată Universitatea Politehnică, vor să se relaxeze aflând câteva detalii despre procesoare.

CPUID este o instrucțiune specială a procesoarelor care folosesc arhitectura x86, sau derivate, care permite aflarea unor informații despre procesorul pe care se execută aceasta instrucțiune.
Instrucțiunea cpuid nu primește parametri, ci se execută în funcție de conținutul registrului eax și, în anumite situații, a registrului ecx.
Informațiile date ca răspuns sunt stocate în registrele eax, ebx, ecx, edx.
Semnificația rezultatelor este documentată în specificațiile producătorilor de procesoare x86, [Intel](https://web.archive.org/web/20120625025623/http://www.intel.com/Assets/PDF/appnote/241618.pdf) si [AMD](https://www.amd.com/system/files/TechDocs/25481.pdf).

Vi se cere să aflați, folosind cpuid, următoarele informații despre procesor:
 - Manufacturer ID-ul (2p + 2p)
 - dacă procesorl folosește [APIC](https://en.wikipedia.org/wiki/Advanced_Programmable_Interrupt_Controller) (1p)
 - dacă este suportată instrucțiunea [RDRAND](https://en.wikipedia.org/wiki/RDRAND) (1p)
 - în cazul în care procesorul este de tip `Intel`, dacă suportă setul de instrucțiuni [MPX](https://en.wikipedia.org/wiki/Intel_MPX) (2p)
 - în cazul în care procesorul este de tip `AMD`, dacă suportă setul de instrucțiuni [SVM](https://en.wikipedia.org/wiki/X86_virtualization#AMD_virtualization_.28AMD-V.29) (3p)
 - dimensiunea liniei de cache de nivel 2 (2p)
 - dimensiunea cache-ului de nivel 2, **pentru un singur nucleu** (2p)

Implementarea se va face în fișierul `task4.asm`.

## Precizări

 - Checker-ul va verifica ce tip de procesor este prezent și va verifica output-ul funcțiilor voastre in funcție de prezența componentelor cerute pe sistem (dacă procesorul vostru este Intel și nu are MPX, se va aștepta ca rezultatul pentru MPX sa fie 0)
 - Checker-ul va emula celălalt procesor, cu **toate componentele cerute**, folosind `qemu-i386`.
 - Implementarea trebuie să poată verifica și componentele specifice Intel, și cele specifice AMD, în funcție de ce tip de procesor e detectat.
 - Informatii despre cache-ul de nivelul 2 se pot obtine folosind EAX=0x80000006 sau EAX=0x2.
 Folosind EAX=0x80000006 se poate afisa o dimensiune de maxim 512KB.
 Pentru dimensiuni mai mari, trebuie folosit EAX=0x2, care implica parsarea registrelor EAX, EBX, ECX, EDX, astfel:
 AL indica e cate ori trebuie apelat CPUID cu EAX=0x2, pentru a obtine date valide.
 Bit-ul 31 din fiecare registru indica daca contine date valide (valoarea 0) sau nu (valoarea 1).
 Daca un registru contine date valide, acesta va contine cate o valoare pe un byte, cu o anumita specificatie.
 specificatia fiecarui byte poate fi gasita [aici](https://c9x.me/x86/html/file_module_x86_id_45.html), la sectiunea **INPUT EAX = 2:**.
