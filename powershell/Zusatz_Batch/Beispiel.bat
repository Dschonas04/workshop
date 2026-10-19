@echo off
chcp 65001 >nul
title Batch-Beispiele
:: ================================================================
::  Zusatz: Batch-Scripting – BEISPIELE
::  Doppelklicke diese Datei oder führe sie in CMD aus.
:: ================================================================

:: --- Ausgabe ---
echo ========================================
echo   Willkommen zum Batch-Kurs!
echo ========================================
echo.

:: --- Variablen ---
set name=PowerShell-Schüler
set /a alter=25
set /a naechstes_jahr=%alter%+1
echo Hallo %name%!
echo Du bist %alter% Jahre alt.
echo Nächstes Jahr bist du %naechstes_jahr%.
echo.

:: --- Benutzereingabe ---
set /p benutzername=Wie heißt du? 
echo Hallo %benutzername%, schöner Name!
echo.

:: --- Bedingungen ---
set /a zahl=42
if %zahl% GEQ 40 (
    echo %zahl% ist größer oder gleich 40.
) else (
    echo %zahl% ist kleiner als 40.
)
echo.

:: --- Schleifen ---
echo Zähle von 1 bis 5:
for /l %%i in (1,1,5) do (
    echo   Nummer: %%i
)
echo.

echo Obst-Liste:
for %%f in (Apfel Birne Kirsche Mango) do (
    echo   - %%f
)
echo.

:: --- Dateiverwaltung ---
echo Erstelle Testordner und Dateien...
mkdir TestOrdner 2>nul
echo Zeile 1: Hallo Welt > TestOrdner\test.txt
echo Zeile 2: Batch ist alt aber nützlich >> TestOrdner\test.txt
echo Zeile 3: Fertig! >> TestOrdner\test.txt

echo Inhalt von test.txt:
type TestOrdner\test.txt
echo.

:: Dateien auflisten
echo Dateien im TestOrdner:
dir /b TestOrdner
echo.

:: Prüfen ob Datei existiert
if exist "TestOrdner\test.txt" (
    echo Die Datei existiert!
) else (
    echo Datei nicht gefunden!
)
echo.

:: Aufräumen
rmdir /s /q TestOrdner
echo Testordner aufgeräumt.
echo.

:: --- Funktionen (simuliert) ---
echo Funktionsbeispiel:
call :Begrüßung "Welt"
call :Begrüßung "Batch"
call :Addiere 10 20
echo.
goto :WeiterNachFunktionen

:Begrüßung
echo   Hallo, %~1!
goto :eof

:Addiere
set /a ergebnis=%~1+%~2
echo   %~1 + %~2 = %ergebnis%
goto :eof

:WeiterNachFunktionen

:: --- Fehlerbehandlung ---
echo Fehlerbehandlung:
dir NichtExistierenderOrdner >nul 2>&1
if %errorlevel% neq 0 (
    echo   Erwarteter Fehler: Ordner existiert nicht.
) else (
    echo   Kein Fehler.
)
echo.

:: --- Nützliche Befehle ---
echo System-Info:
echo   Benutzer: %username%
echo   Computer: %computername%
echo   Datum:    %date%
echo   Zeit:     %time%
echo   OS:       %os%
echo.

echo ========================================
echo   Alle Beispiele abgeschlossen!
echo ========================================
pause
