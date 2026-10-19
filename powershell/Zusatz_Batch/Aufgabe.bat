@echo off
chcp 65001 >nul
title Batch-Aufgaben
:: ================================================================
::  Zusatz: Batch-Scripting – AUFGABEN
::  Ersetze ___ durch den richtigen Code.
::  Entferne REM vor den Zeilen, um sie zu aktivieren.
:: ================================================================

:: ── AUFGABE B.1: Ausgabe & Variablen ────────────────────────
:: Erstelle Variablen für deinen Namen und dein Alter.
:: Gib aus: "Ich bin [Name] und [Alter] Jahre alt."

REM set name=___
REM set /a alter=___
REM echo Ich bin %___% und %___% Jahre alt.


:: ── AUFGABE B.2: Benutzereingabe & Bedingung ───────────────
:: Frage den Benutzer nach einer Zahl.
:: Wenn die Zahl >= 18 ist, gib "Volljährig" aus.
:: Sonst gib "Minderjährig" aus.

REM set /p zahl=Gib eine Zahl ein: 
REM if %zahl% ___ 18 (
REM     echo ___
REM ) else (
REM     echo ___
REM )


:: ── AUFGABE B.3: Schleifen ─────────────────────────────────
:: Zähle von 2 bis 20 in 2er-Schritten (2, 4, 6, ... 20)
:: Tipp: for /l %%i in (Start,Schritt,Ende) do ...

REM for /l %%i in (___,___,___) do echo %%i


:: ── AUFGABE B.4: Dateien erstellen ─────────────────────────
:: Erstelle einen Ordner "MeinBatchTest".
:: Erstelle darin 3 Dateien mit unterschiedlichem Text.
:: Zeige den Inhalt aller Dateien an.

REM mkdir ___
REM echo Erste Datei > ___\datei1.txt
REM echo ___ > ___\datei2.txt
REM echo ___ > ___\datei3.txt
REM for %%f in (___\*.txt) do (
REM     echo --- %%f ---
REM     type %%f
REM )


:: ── AUFGABE B.5: Funktion schreiben ────────────────────────
:: Schreibe eine "Funktion" :Multipliziere die zwei Parameter
:: multipliziert und das Ergebnis ausgibt.
:: Rufe sie mit: call :Multipliziere 7 8

REM call :Multipliziere 7 8
REM goto :Ende
REM
REM :Multipliziere
REM set /a ergebnis=___
REM echo %~1 x %~2 = %ergebnis%
REM goto :eof
REM
REM :Ende


:: ── BONUS ──────────────────────────────────────────────────
:: Erstelle ein kleines Menü-System mit GOTO:
:: 1) Datum anzeigen
:: 2) Benutzer anzeigen
:: 3) Beenden
:: Tipp: Nutze set /p, if/goto und Labels

echo.
echo Alle Aufgaben befinden sich oben im Code!
echo Entferne REM und ersetze ___ um sie zu lösen.
pause
