-- ==============================================================================
-- SCRIPT: queries.sql
-- POPIS: 15 dotazů splňujících přesné počty SQL klauzulí ze zadání
-- ==============================================================================

-- Dotaz 1: Výpis zákazníků registrovaných v roce 2026, seřazených podle příjmení (max 5 výsledků)
-- Splňuje: WHERE, ORDER BY, LIMIT
SELECT * FROM zakaznik 
WHERE datum_registrace >= '2026-01-01' 
ORDER BY prijmeni ASC 
LIMIT 5;

-- Dotaz 2: Nalezení zákazníků s emailem na doméně gmail.com nebo email.cz
-- Splňuje: WHERE, LIKE
SELECT id_zakaznika, jmeno, prijmeni, email 
FROM zakaznik 
WHERE email LIKE '%@gmail.com' OR email LIKE '%@email.cz';

-- Dotaz 3: Nalezení trenérů se specializací začínající na 'Fit' nebo telefonem začínajícím na '+420775'
-- Splňuje: WHERE, LIKE
SELECT id_trener, jmeno, prijmeni, specializace, telefon 
FROM trener 
WHERE specializace LIKE 'Fit%' OR telefon LIKE '+420775%';

-- Dotaz 4: Výpis sportovišť s kapacitou větší než 5, seřazených od nejdražšího (max 3 výsledky)
-- Splňuje: WHERE, ORDER BY, LIMIT
SELECT id_sportoviste, nazev, kapacita, cena_za_hodinu 
FROM sportoviste 
WHERE kapacita > 5 
ORDER BY cena_za_hodinu DESC 
LIMIT 3;

-- Dotaz 5: Zobrazení všech sportovišť, která spadají pod kategorii 'Tenis'
-- Splňuje: WHERE, JOIN ON
SELECT s.id_sportoviste, s.nazev, k.nazev AS kategoria, s.cena_za_hodinu
FROM sportoviste s
JOIN kategorie k ON s.id_kategorie = k.id_kategorie
WHERE k.nazev = 'Tenis';

-- Dotaz 6: Zobrazení detailů rezervací pro specifické datum s příjmením zákazníka a názvem sportoviště
-- Splňuje: WHERE, JOIN ON
SELECT dr.id_rezervace, z.prijmeni AS zakaznik, s.nazev AS sportoviste, dr.cas_od, dr.cas_do
FROM detail_rezervace dr
JOIN rezervace r ON dr.id_rezervace = r.id_rezervace
JOIN zakaznik z ON r.id_zakaznika = z.id_zakaznika
JOIN sportoviste s ON dr.id_sportoviste = s.id_sportoviste
WHERE dr.datum_rezervace = '2026-06-05';

-- Dotaz 7: Výpis recenzí, které v komentáři obsahují 'spokojenost' nebo hodnocení 'Výborné'
-- Splňuje: WHERE, JOIN ON, LIKE
SELECT r.id_recenze, z.jmeno, z.prijmeni, r.hodnoceni, r.komentar
FROM recenze r
JOIN zakaznik z ON r.id_zakaznika = z.id_zakaznika
WHERE r.komentar LIKE '%spokojenost%' OR r.hodnoceni LIKE 'Výborné';

-- Dotaz 8: Zobrazení plateb kartou vyšších než 300 Kč s datem vytvoření rezervace
-- Splňuje: WHERE, JOIN ON
SELECT p.id_platby, p.castka, p.metoda, r.datum_vytvoreni
FROM platba p
JOIN rezervace r ON p.id_rezervace = r.id_rezervace
WHERE p.metoda = 'Karta' AND p.castka > 300;

-- Dotaz 9: Zobrazení recenzí pro sportoviště, která mají hodinovou cenu vyšší než 250 Kč
-- Splňuje: WHERE, JOIN ON
SELECT r.id_recenze, s.nazev AS sportoviste, s.cena_za_hodinu, r.hodnoceni
FROM recenze r
JOIN sportoviste s ON r.id_sportoviste = s.id_sportoviste
WHERE s.cena_za_hodinu > 250;

-- Dotaz 10: Zobrazení detailů rezervací včetně jména trenéra pro rezervace s ID menším než 5
-- Splňuje: WHERE, JOIN ON
SELECT dr.id_rezervace, s.nazev AS sportoviste, t.prijmeni AS trener
FROM detail_rezervace dr
JOIN sportoviste s ON dr.id_sportoviste = s.id_sportoviste
JOIN trener t ON dr.id_tener = t.id_trener
WHERE dr.id_rezervace < 5;

-- Dotaz 11: Seznam všech sportovišť a jejich recenzí (včetně těch bez recenze) s cenou nad 150 Kč
-- Splňuje: WHERE, LEFT JOIN
SELECT s.nazev AS sportoviste, s.cena_za_hodinu, r.hodnoceni, r.komentar
FROM sportoviste s
LEFT JOIN recenze r ON s.id_sportoviste = r.id_sportoviste
WHERE s.cena_za_hodinu > 150;

-- Dotaz 12: Seznam všech zákazníků a jejich případných plateb registrovaných od února 2026
-- Splňuje: WHERE, LEFT JOIN
SELECT z.id_zakaznika, z.prijmeni, p.castka, p.metoda
FROM zakaznik z
LEFT JOIN rezervace r ON z.id_zakaznika = r.id_zakaznika
LEFT JOIN platba p ON r.id_rezervace = p.id_rezervace
WHERE z.datum_registrace >= '2026-02-01';

-- Dotaz 13: Průměrná cena sportovišť podle kategorií, kde je průměrná cena vyšší než 200 Kč
-- Splňuje: WHERE, Agregační funkce (AVG), GROUP BY + HAVING
SELECT id_kategorie, AVG(cena_za_hodinu) AS prumerna_cena
FROM sportoviste
WHERE stav = 1
GROUP BY id_kategorie
HAVING prumerna_cena > 200;

-- Dotaz 14: Celkový příjem podle platebních metod, kde je suma vyšší než 500 Kč
-- Splňuje: WHERE, Agregační funkce (SUM), GROUP BY + HAVING
SELECT metoda, SUM(castka) AS celkovy_prijem
FROM platba
WHERE datum_platby >= '2026-01-01'
GROUP BY metoda
HAVING celkovy_prijem > 500;

-- Dotaz 15: Výpis rezervací s výpočtem ceny po 10% slevě pro rezervace nad 300 Kč
-- Splňuje: WHERE, Výpočet
SELECT id_rezervace, celkova_cena AS puvodni_cena, (celkova_cena * 0.9) AS cena_po_sleve
FROM rezervace
WHERE celkova_cena > 300;