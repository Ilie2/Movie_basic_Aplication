/*method Triple(x: int) returns (r: int)
{
    var y := 2 * x;
    r := x + y;
    assert r == 3 * x;
}*/
/*Rezultatul ar trebui să fie că Dafny verifică cu succes corectitudinea codului. Acest lucru se întâmplă deoarece aserția assert r == 3 * x; este adevărată pentru toate valorile posibile ale lui x.

Acum, dacă schimbi condiția aserției la 3*x + 1, codul devine:*/
/*method Triple(x: int) returns (r: int)
{
    var y := 2 * x;
    r := x + y;
    assert r == 10 * x;
    assert false;
}
Dafny probabil va genera o eroare de verificare. Asta se întâmplă pentru că r este calculat ca x + 2 * x, care este egal cu 3 * x, nu 3 * x + 1. Deci, aserția assert r == 3 * x + 1; va eșua pentru cele mai multe valori ale lui x.*/
/*method Triple(x: int) returns (r: int)
{
    var y := 2 * x;
    r := x + y;
    assert r == 10 * x;
    assert r < 5;
    assert false;
}Iată ce vei observa:

Dafny nu va reuși să verifice corectitudinea codului.
Va genera erori de verificare pentru primele două aserțiuni:
Prima aserțiune assert r == 10 * x; va eșua deoarece r este calculat ca x + 2 * x, ceea ce este 3 * x, nu 10 * x.
A doua aserțiune assert r < 5; va eșua de asemenea, deoarece r este 3 * x, care este mai mare sau egal cu 5 pentru cele mai multe valori ale lui x.*/
/*method Triple(x: int) returns (r: int)
{
    var y := 2 * x;
    r := x + y;
    assert r == 10 * x;
    assert x < 0; // Modifică a doua aserțiune pentru a face verificatorul să se plângă
    assert false;
}Prin schimbarea celei de-a doua aserțiuni la assert x < 0;, aceasta va eșua întotdeauna indiferent de valoarea lui r, astfel încât verificatorul va semnala primele două aserțiuni, dar nu și a treia.*/

/*method Triple(x: int) returns (r: int)
{
    if x == 0 {
        r := 0;
    } else {
        var y := 2 * x;
        r := x + y;
    }
    assert r == 3 * x;
}
În acest exemplu, comportamentul este deterministic deoarece instrucțiunea if verifică doar o singură condiție (x == 0), care determină calea de execuție.

Putem oferi următoarele valori pentru x:

x = 0: Acesta va executa ramura if, setând r = 0.
x ≠ 0: Acesta va executa ramura else, calculând r = x + 2 * x = 3 * x.
Exemplu 2: Instrucțiunea If Nedeterministică*/
/*method Triple(x: int) returns (r: int)
{
    if {
        case x < 18 =>
            var a, b := 2 * x, 4 * x;
            r := (a + b) / 2;
        case 0 <= x =>
            var y := 2 * x;
            r := x + y;
    }
    assert r == 3 * x;
}
În acest exemplu, comportamentul este nedeterministic deoarece instrucțiunea if conține mai multe cazuri, iar calea de execuție depinde de valoarea lui x.

Putem oferi următoarele valori pentru x pentru a evidenția comportamentul nedeterministic:

x < 18: Acesta va executa primul caz, setând r = (2 * x + 4 * x) / 2 = 3 * x.
x ≥ 18: Acesta va executa al doilea caz, setând r = x + 2 * x = 3 * x.
Prin furnizarea de valori diferite pentru x, putem demonstra ambele ramuri ale instrucțiunii if, ilustrând comportamentul său nedeterministic.*/
/*method Caller()
{
    var result := Triple(18);
    assert result < 100;
}

method Triple(x: int) returns (r: int)
    ensures r == 3 * x
{
    var y := 2 * x;
    r := x + y;
}
Rezultatul verificatorului:

Verificatorul va confirma că metoda Triple respectă postcondiția specificată, adică r == 3 * x.
Aserția assert result < 100; din metoda Caller va fi, de asemenea, verificată cu succes, deoarece Triple(18) întoarce 54, care este mai mic decât 100.
Exemplu 2:*/
/*method Caller()
{
    var result := Triple(18);
    assert result < 100;
}

method Triple(x: int) returns (r: int)
    requires x % 2 == 0
    ensures r == 3 * x
{
    var y := x / 2;
    r := 6 * y;
}
Rezultatul verificatorului:

Verificatorul va verifica că metoda Triple respectă atât precondiția specificată (requires x % 2 == 0), cât și postcondiția (ensures r == 3 * x).
Aserția assert result < 100; din metoda Caller va fi, de asemenea, verificată cu succes.
Exemplu 3:
Dacă eliminăm sau comentăm precondiția din metoda Triple, vom primi o eroare de verificare. Aceasta se întâmplă deoarece, fără precondiție, nu putem garanta comportamentul corect al metodei pentru anumite valori de intrare. Verificatorul va raporta o eroare care indică faptul că unele căi de execuție nu sunt acoperite sau că postcondiția nu poate fi garantată pentru toate valorile de intrare.

2. Rolul precondiției și postcondiției:
Precondiția (requires): Specifică condițiile care trebuie să fie adevărate înainte ca metoda să fie apelată. Ajută la asigurarea utilizării corecte a metodei.
Postcondiția (ensures): Specifică condițiile care trebuie să fie adevărate după execuția metodei. Asigură că metoda respectă specificațiile ei.
3. Eliminarea precondiției din Triple:
Eliminând sau comentând precondiția (requires x % 2 == 0) din metoda Triple, verificatorul va raporta o eroare de verificare. Aceasta se datorează faptului că metoda nu mai este restricționată la valorile de intrare care respectă condiția x % 2 == 0, iar astfel nu se poate garanta că postcondiția va fi îndeplinită pentru toate valorile de intrare.

4. Două alternative mai puternice pentru precondiția x % 2 == 0:
requires x % 2 == 0 && x >= 0: Această precondiție asigură că x este pozitiv și par.
requires x % 6 == 0: Această precondiție garantează că x este divizibil cu 6, ceea ce implică că este și par.*/








