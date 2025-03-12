## Kommentar til ER-model

Vi har designet databasen til at dække de centrale funktioner i et fitnesscenter. Vi har bygget modellen efter en fordeling som indeholder: medlemskab, træningshold, instruktører, booking, betaling og medlemsrabatter.

### Overvejelser undervejs

#### 1. Struktur og relationer
Vi har skabt en klar struktur, hvor de vigtigste entiteter er forbundet logisk. Vi har startet med en tabel for medlemmer, som er gennemgående for vores design. Alt er bygget op efter tabellen. Tabel **medlem** har relation til tabel **Medlemskab**, hvilket sikrer, at hvert medlem har et defineret abonnement. **Booking** forbinder medlemmer med træningshold og håndterer status for deres tilmelding.

#### 2. Brug af ENUM
For at forenkle håndteringen af faste værdier har vi anvendt **ENUM** i flere tabeller. For eksempel bruges **ENUM** i **Medlemskab** til at definere typer (*Basis, Premium, Elite*) og i **Booking** til status (*Bekræftet, Venteliste*). Dette sikrer dataintegritet og gør forespørgsler nemmere. Derudover minimeres fejl.

#### 3. Ventelistehåndtering
Vi har inkluderet en **Status-kolonne** i **Booking**, der angiver, om en booking er bekræftet eller på venteliste. Under processen har vi diskuteret om en mulig forbedring kunne være at tilføje et **Venteliste nummer**. Herved kan systemet bedre håndtere rækkefølgen af ventelistepladser mere præcist. Vi har imidlertid vurderet at vente med forbedringerne til næste version.

#### 4. Betaling og rabatter
**Betaling-tabellen** registrerer medlemskabets betalinger og har en kolonne til **Medlemsrabat**. Vi har også snakket om en mulig forbedring kunne være en separat **Discount-tabel** for at håndtere forskellige typer rabatter, såsom firmaaftaler eller kampagner, hvilket ville gøre systemet mere fleksibelt. Den beslutning kunne vi ikke træffe, da vi skal udføre flere tests for at kunne vurdere, om det er bedst at have en **Discount-tabel** eller beholde det, som det er.

#### 5. Instruktører og træningshold
Hvert **træningshold** har en tilknyttet **instruktør**, hvilket sikrer, at der er en ansvarlig for hvert hold. Hvis systemet skal understøtte **personlig træning**, kunne vi udvide **Booking** til også at inkludere en **instruktørrelation**.

### Særlige opmærksomhedspunkter
Vi har fokuseret på at minimere redundans og sikre, at alle relationer giver mening i en virkelig kontekst. Der er plads til yderligere forbedringer, særligt i **ventelistehåndtering** og **rabatstyring**. Modellen er skalerbar og kan udvides med nye funktioner, hvis fitnesscentret får behov for det.

---

## Normalisering af ER-modellen
Efter vi har bygget vores **ER-model**, har vi gennemgået de tre normaliseringsformer for at sikre, at modellen er optimeret.

### 1NF (Første normalform)
**Regel:** Alle attributter skal være **atomare**, og der må ikke være **gentagne grupper** i en tabel.

**Gennemgang af modellen:**
- Alle kolonner i vores tabeller indeholder atomare værdier (*ingen lister eller grupper i én celle*). 
  - *Eksempel:* **Medlem-tabellen** har attributterne *Navn, Email og Telefon*, som alle er enkeltstående værdier.
- Der er ingen gentagne grupper i tabellerne, så vores model overholder allerede **1NF**.
- Gruppen har snakket om en mulig udfordring i **1NF**, hvis et medlem har **flere telefonnumre** i samme kolonne. Dette ville bryde reglen. Derfor har vi besluttet, at hvis fitnesscenteret ønsker, at et medlem kan have flere telefonnumre, bør vi lave en **separat Telefon-tabel** med en relation til **Medlem**.

### 2NF (Anden normalform)
**Regel:** Tabellen skal allerede være i **1NF**, og alle ikke-nøgle attributter skal **afhænge af hele primærnøglen** (ikke kun en del af den).

**Gennemgang af modellen:**
- **Booking** har en **sammensat nøgle** (*Booking_id*), men alle ikke-nøgle attributter afhænger af **hele** primærnøglen.
- **Betaling** er korrekt normaliseret, da *Betalingsdato, Beløb og Medlemsrabat* afhænger af **Betalings_id** (*unik nøgle*).
- **Træningshold** er også i **2NF**, da *Navn, Kalender, Max Deltagere og Instruktør_id* alle afhænger af **Hold_id**.
- **Ikke-normaliseret tabel (brudt 2NF):**
  - Hvis vi tilføjer *Medlems_navn* til **Booking-tabellen**.
  - **Problem:** *Medlems_navn* afhænger kun af *Medlems_id*, ikke hele primærnøglen *Booking_id*.
  - Derfor ville tabellen **ikke** være i **2NF**.

### 3NF (Tredje normalform)
**Regel:** Tabellen skal være i **2NF**, og der må ikke være **transitive afhængigheder** (hvor en ikke-nøgle attribut afhænger af en anden ikke-nøgle attribut i stedet for primærnøglen).

**Gennemgang af modellen:**
- **Medlem-tabellen** har ingen **transitive afhængigheder**. *Navn, Email og Telefon* afhænger kun af **Medlem_id**.
- **Betaling** er i **3NF**, da *Beløb, Betalingsdato og Medlemsrabat* kun afhænger af **Betalings_id**.
- **Booking-tabellen** har en **Status-attribut (ENUM)**, men denne afhænger direkte af **Booking_id**, ikke af en anden ikke-nøgle attribut.
- **Eksempel på brudt 3NF:**
  - Vi diskuterede, at **Betaling** havde en kolonne **Medlemsfordele**.
  - **Problem:** *Medlemsfordele* afhænger af **Medlemskabstype**, hvilket betyder, at vi ville bryde **3NF**.
  - **Løsning:** Flytte *Medlemsfordele* til **Medlemskab-tabellen** i stedet for **Betaling**. 
  - Herved behøver vi kun at **opdatere én række** i **Medlemskab**, hvis fordelene ændres.

---

## Konklusion
- Vores model er allerede i **1NF**, da alle attributter er atomare.
- Modellen er i **2NF**, fordi alle ikke-nøgle attributter afhænger af **hele primærnøglen**.
- Modellen er i **3NF**, fordi der **ikke** er transitive afhængigheder (*hvor en ikke-nøgleattribut afhænger af en anden ikke-nøgleattribut, som igen afhænger af primærnøglen*).
