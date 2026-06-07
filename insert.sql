-- ==========================================
-- SCRIPT: insert.sql
-- POPIS: Naplnění tabulek testovacími daty
-- SPLŇUJE: Každá tabulka obsahuje přesně 7 záznamů
-- ==========================================

-- 1. kategorie
INSERT INTO kategorie (id_kategorie, nazev, popis, sportoviste_id_sportoviste) VALUES
(1, 'Tenis', 'Venkovní i vnitřní tenisové kurty.', NULL),
(2, 'Squash', 'Uzavřené kurty na squash.', NULL),
(3, 'Fitness', 'Klimatizovaná posilovna.', NULL),
(4, 'Plavani', 'Krytý bazén 25m.', NULL),
(5, 'Badminton', 'Kurty v hlavní hale.', NULL),
(6, 'Fotbal', 'Hřiště s umělou trávou.', NULL),
(7, 'Wellness', 'Sauna a vířivky.', NULL);

-- 2. zakaznik
INSERT INTO zakaznik (id_zakaznika, jmeno, prijmeni, email, telefon, datum_registrace, recenze_id_recenze, rezervace_id_rezervace) VALUES
(1, 'Jan', 'Novak', 'jan.novak@email.cz', '+420123456789', '2026-01-15', NULL, NULL),
(2, 'Petr', 'Svoboda', 'petr.svoboda@gmail.com', '+420987654321', '2026-01-20', NULL, NULL),
(3, 'Marie', 'Cerna', 'marie.cerna@seznam.cz', '+420603111222', '2026-02-02', NULL, NULL),
(4, 'Eva', 'Dvorakova', 'eva.dvorakova@email.cz', '+420777333444', '2026-02-10', NULL, NULL),
(5, 'Pavel', 'Kucera', 'pavel.kucera@gmail.com', '+420608555666', '2026-03-01', NULL, NULL),
(6, 'Jiri', 'Vesely', 'jiri.vesely@seznam.cz', '+420731888999', '2026-03-12', NULL, NULL),
(7, 'Hana', 'Krejci', 'hana.krejci@email.cz', '+420723000111', '2026-04-05', NULL, NULL);

-- 3. trener
INSERT INTO trener (id_trener, jmeno, prijmeni, email, telefon, specializace, detail_rezervace_id_rezervace, detail_rezervace_id_sportoviste, detail_rezervace_id_tener) VALUES
(1, 'Tomas', 'Marny', 'tomas.marny@center.cz', '+420777111222', 'Tenis', NULL, NULL, NULL),
(2, 'Lukas', 'Rychly', 'lukas.rychly@center.cz', '+420777333444', 'Fitness', NULL, NULL, NULL),
(3, 'Anna', 'Slaba', 'anna.slaba@center.cz', '+420777555666', 'Plavani', NULL, NULL, NULL),
(4, 'Martin', 'Sikovny', 'martin.sikovny@center.cz', '+420777777888', 'Badminton', NULL, NULL, NULL),
(5, 'Jan', 'Kopacka', 'jan.kopacka@center.cz', '+420777999000', 'Fotbal', NULL, NULL, NULL),
(6, 'Michal', 'Zkuseny', 'michal.zkuseny@center.cz', '+420775111333', 'Squash', NULL, NULL, NULL),
(7, 'Klara', 'Obratna', 'klara.obratna@center.cz', '+420775222444', 'Fitness', NULL, NULL, NULL);

-- 4. sportoviste
INSERT INTO sportoviste (id_sportoviste, id_kategorie, nazev, kapacita, cena_za_hodinu, stav, detail_rezervace_id_rezervace, detail_rezervace_id_sportoviste, detail_rezervace_id_tener, recenze_id_recenze) VALUES
(1, 1, 'Tenisovy kurt A', 4, 400, 1, NULL, NULL, NULL, NULL),
(2, 1, 'Tenisovy kurt B', 4, 500, 1, NULL, NULL, NULL, NULL),
(3, 2, 'Squashovy kurt 1', 2, 300, 1, NULL, NULL, NULL, NULL),
(4, 3, 'Posilovna - Hlavni', 50, 150, 1, NULL, NULL, NULL, NULL),
(5, 4, 'Plavecka draha 1', 8, 200, 1, NULL, NULL, NULL, NULL),
(6, 5, 'Badmintonovy kurt 1', 4, 250, 1, NULL, NULL, NULL, NULL),
(7, 6, 'Fotbalove hriste', 22, 800, 1, NULL, NULL, NULL, NULL);

-- 5. rezervace
INSERT INTO rezervace (id_rezervace, id_zakaznika, datum_vytvoreni, stav_rezervace, celkova_cena, platba_id_platby, detail_rezervace_id_rezervace, detail_rezervace_id_sportoviste, detail_rezervace_id_tener) VALUES
(1, 1, '2026-05-01', 2, 400, NULL, NULL, NULL, NULL),
(2, 2, '2026-05-02', 2, 300, NULL, NULL, NULL, NULL),
(3, 3, '2026-05-05', 2, 1100, NULL, NULL, NULL, NULL),
(4, 4, '2026-05-10', 2, 200, NULL, NULL, NULL, NULL),
(5, 5, '2026-05-12', 2, 1600, NULL, NULL, NULL, NULL),
(6, 6, '2026-05-15', 1, 250, NULL, NULL, NULL, NULL),
(7, 7, '2026-05-20', 1, 500, NULL, NULL, NULL, NULL);

-- 6. detail_rezervace
INSERT INTO detail_rezervace (id_rezervace, id_sportoviste, datum_rezervace, cas_od, cas_do, id_tener) VALUES
(1, 1, '2026-06-01', '10:00:00', '11:00:00', 1),
(2, 3, '2026-06-02', '14:00:00', '15:00:00', NULL),
(3, 2, '2026-06-05', '16:00:00', '18:00:00', 1),
(4, 5, '2026-06-06', '09:00:00', '10:00:00', 3),
(5, 7, '2026-06-07', '10:00:00', '12:00:00', 5),
(6, 6, '2026-06-08', '11:00:00', '12:00:00', NULL),
(7, 2, '2026-06-09', '15:00:00', '16:00:00', NULL);

-- 7. platba
INSERT INTO platba (id_platby, id_rezervace, castka, datum_platby, metoda) VALUES
(1, 1, 400, '2026-05-01', 'Karta'),
(2, 2, 300, '2026-05-02', 'Hotovost'),
(3, 3, 1100, '2026-05-05', 'Karta'),
(4, 4, 200, '2026-05-10', 'Prevod'),
(5, 5, 1600, '2026-05-12', 'Karta'),
(6, 6, 250, '2026-05-15', 'Hotovost'),
(7, 7, 500, '2026-05-20', 'Karta');

-- 8. recenze
INSERT INTO recenze (id_recenze, id_zakaznika, id_sportoviste, hodnoceni, komentar, datum_vytvoreni) VALUES
(1, 1, 1, 'Výborné', 'Skvělý povrch, spokojenost.', '2026-06-01'),
(2, 2, 3, 'Dobré', 'Čisté prostředí.', '2026-06-02'),
(3, 3, 2, 'Výborné', 'Super osvětlení haly.', '2026-06-05'),
(4, 4, 5, 'Průměrné', 'Studená voda v bazénu.', '2026-06-06'),
(5, 5, 7, 'Výborné', 'Skvělá tráva na fotbal.', '2026-06-07'),
(6, 6, 6, 'Dobré', 'Klasický badminton.', '2026-06-08'),
(7, 7, 2, 'Výborné', 'Bezproblémová rezervace.', '2026-06-09');