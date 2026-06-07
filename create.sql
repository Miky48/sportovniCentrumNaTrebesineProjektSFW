-- ==========================================
-- SCRIPT: create.sql
-- POPIS: Vytvoření struktury databáze přesně podle ER diagramu
-- SPLŇUJE: 8 entit, 1 identifikační závislost, atributy přesně podle obrázku
-- ==========================================

-- 1. Tabulka: kategorie
CREATE TABLE kategorie (
    id_kategorie INT PRIMARY KEY,
    nazev VARCHAR(45),
    popis LONGTEXT,
    sportoviste_id_sportoviste INT
);

-- 2. Tabulka: zakaznik
CREATE TABLE zakaznik (
    id_zakaznika INT PRIMARY KEY,
    jmeno VARCHAR(45),
    prijmeni VARCHAR(45),
    email VARCHAR(45),
    telefon VARCHAR(15),
    datum_registrace DATE,
    recenze_id_recenze INT,
    rezervace_id_rezervace INT
);

-- 3. Tabulka: trener
CREATE TABLE trener (
    id_trener INT PRIMARY KEY,
    jmeno VARCHAR(45),
    prijmeni VARCHAR(45),
    email VARCHAR(45),
    telefon VARCHAR(15),
    specializace VARCHAR(45),
    detail_rezervace_id_rezervace INT,
    detail_rezervace_id_sportoviste INT,
    detail_rezervace_id_tener INT
);

-- 4. Tabulka: sportoviste
CREATE TABLE sportoviste (
    id_sportoviste INT PRIMARY KEY,
    id_kategorie INT,
    nazev VARCHAR(45),
    kapacita INT,
    cena_za_hodinu INT,
    stav TINYINT,
    detail_rezervace_id_rezervace INT,
    detail_rezervace_id_sportoviste INT,
    detail_rezervace_id_tener INT,
    recenze_id_recenze INT,
    FOREIGN KEY (id_kategorie) REFERENCES kategorie(id_kategorie)
);

-- 5. Tabulka: rezervace
CREATE TABLE rezervace (
    id_rezervace INT PRIMARY KEY,
    id_zakaznika INT,
    datum_vytvoreni DATE,
    stav_rezervace TINYINT,
    celkova_cena INT,
    platba_id_platby INT,
    detail_rezervace_id_rezervace INT,
    detail_rezervace_id_sportoviste INT,
    detail_rezervace_id_tener INT,
    FOREIGN KEY (id_zakaznika) REFERENCES zakaznik(id_zakaznika)
);

-- 6. Tabulka: detail_rezervace (Identifikační závislost se složeným PK)
CREATE TABLE detail_rezervace (
    id_rezervace INT,
    id_sportoviste INT,
    datum_rezervace DATE,
    cas_od TIME,
    cas_do TIME,
    id_tener INT,
    PRIMARY KEY (id_rezervace, id_sportoviste),
    FOREIGN KEY (id_rezervace) REFERENCES rezervace(id_rezervace),
    FOREIGN KEY (id_sportoviste) REFERENCES sportoviste(id_sportoviste),
    FOREIGN KEY (id_tener) REFERENCES trener(id_trener)
);

-- 7. Tabulka: platba
CREATE TABLE platba (
    id_platby INT PRIMARY KEY,
    id_rezervace INT,
    castka INT,
    datum_platby DATE,
    metoda VARCHAR(45),
    FOREIGN KEY (id_rezervace) REFERENCES rezervace(id_rezervace)
);

-- 8. Tabulka: recenze
CREATE TABLE recenze (
    id_recenze INT PRIMARY KEY,
    id_zakaznika INT,
    id_sportoviste INT,
    hodnoceni VARCHAR(45),
    komentar VARCHAR(45),
    datum_vytvoreni DATE,
    FOREIGN KEY (id_zakaznika) REFERENCES zakaznik(id_zakaznika),
    FOREIGN KEY (id_sportoviste) REFERENCES sportoviste(id_sportoviste)
);