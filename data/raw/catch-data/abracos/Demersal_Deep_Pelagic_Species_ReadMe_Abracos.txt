---------------------------------------------------------
Dataset of demersal and deep-pelagic macroalgae, invertebrates and fishes collected during the ABRACOS expeditions in the Tropical Western Atlantic
Abracos 1 & 2

2025/07/01

Type of File: CSV
              Decimal point: "."
              Separator: ";"
---------------------------------------------------------

This dataset compiles information on the macroalgae, invertebrates (sponges, cnidarians, siphonophores, molluscs, crustaceans and tunicates) 
and fishes collected during the ABRACOS 1 (29 September–21 October 2015) and ABRACOS 2 (8 April–9 May 2017) expeditions 
along the northeastern Brazilian margin (approximately 3°S to 9°S and 35°W to 31°W), encompassing the continental shelf, 
the Fernando de Noronha Archipelago, Rocas Atoll, and adjacent seamounts. 

The dataset includes records of approximately 21,524 specimens, representing 16 classes, 86 orders, 218 families, 400 genera, and 512 species. 
For most specimens, complete taxonomic identifications, georeferenced coordinates, and sampling depths are provided. 
Morphometric data are also available for several specimens.

The dataset has been organised into 3 categories of files:

1. A global species list including 691 taxa with their complete taxonomy: 
    -> Demersal_Deep_Pelagic_Species_List_Abracos.csv
2. For each survey, the description of all fishing operations: 
    -> Demersal_Deep_Pelagic_Survey_Station_Abracos1.csv
    -> Demersal_Deep_Pelagic_Survey_Station_Abracos2.csv
3. For each survey, the biological information collected for every organism: 
    -> Demersal_Deep_Pelagic_Biological_Data_Abracos1.csv
    -> Demersal_Deep_Pelagic_Biological_Data_Abracos2.csv


1. Demersal_Deep_Pelagic_Species_List_Abracos.csv

This table lists all 691 taxa observed with their taxonomy

Taxa were identified at the highest possible taxonomic level: Species (515 taxa), Genus (125 taxa), Family (32 taxa), Order (7 taxa) ...

The taxonomy was verified using Eschmeyer's Catalog of Fishes (https://www.calacademy.org/scientists/projects/eschmeyers-catalog-of-fishes) for fishes 
and World Register of Marine Species "WoRMS" (http://www.marinespecies.org)for all other taxa.
All taxonomic details were obtained from WoRMS using the field "Scientific_Name_Worms" 
allowing to connect to WoRMS database, except for taxa with very unprecise identification (e.g. "Fish larvae", "Jellyfish"...) 
and for new fish species recently added to Eschmeyer's Catalog of Fishes and not yet integrated in WoRMS.

The file "Demersal_Deep_Pelagic_Species_List_Abracos.csv" contains the following fields /columns:

Column Name		Type of Data				Modalities / Units

Species			Taxonomic identification		Unique taxonomic identifier including "sp.", "sp. 1", "sp. nov. 1", etc. (ex: "Acanthostracion polygonium", "Abylopsis sp.")
Code_Species		Species code				First four letters of Genus and first four letters of Species, except if ambiguous (ex. "Acan.poly", "Abyl.sp", "Acanthephyra.quad")
Compartment		Minimum taxonomic compartment		"CRUS" (crustaceans) / "FISH" / "GELATINOUS" / "MACROALGAE" / "MOLL" (molluscs)/ "SPONGES"
AphiaID_Worms		WoRMS AphiaID				Ex: 1577312 - NaN if not in WoRMS
Scientific_Name_Worms	Scientific name to search WoRMS		Similar to "Species" except sp, sp1, etc.(ex: "Acanthostracion polygonium", "Abylopsis") - Can be used to check the taxonomy with WoRMS
Authority_Worms		Authority = Descriptor of the species	Ex: (Rüppell, 1844), Chun, 1888
Kingdom			Kingdom					Animalia / Chromista / Plantae / NaN
Phylum			Phylum					Ex: Chordata
Class			Class					Ex: Teleostei
Order			Order					Ex: Tetraodontiformes
Family			Family					Ex: Ostracidae
Genus			Genus					Ex: Acanthostracion
rank			Identification level			Species / Genus / Family…


2. Demersal_Deep_Pelagic_Survey_Station_Abracos1.csv
   Demersal_Deep_Pelagic_Survey_Station_Abracos2.csv

For each survey, these files summarize information concerning the fishing operations,
including space-time location and technical characteristics of the fishing operation.

Three types of trawl gear were employed: 
(1) bottom trawl (body mesh: 40 mm; cod-end mesh: 25 mm; entrance dimensions: 28 × 10 m); 
(2) mesopelagic trawl (body mesh: 30 mm; cod-end mesh: 4 mm; net mouth: 16.6 × 8.4 m); and 
(3) micronekton trawl (body mesh: 40 mm; cod-end mesh: 10 mm; net mouth: 24 × 24 m). 

Bottom trawls were conducted at depths ranging from 10 to 60 meters, while pelagic trawls targeted depths between 10 and 1100 meters. 
All gear types were deployed during both day and night operations. 

During the first survey (ABRACOS 1), 48 samples were collected : 17 using bottom trawl, 27 using mesopelagic trawl and 4 using micronekton trawl.
During the second survey (ABRACOS 2), 68 samples were collected: 19 using bottom trawl, 4 using mesopelagic trawl and 45 using micronekton trawl.

The files contains the following fields /columns:

Column Name		Type of Data					Modalities / Units

Id_Survey		Survey Identification				"Abracos_1" / "Abracos_2"
Id_Survey_Pos		Chronological order of the points			"A1_N° of line in the logbook" "A2_N° of line in the logbook"
Station			Station Number for a given survey		1-> 54 for Abracos 1 (ex: 54) ; 1-> 60 for Abracos 2 + a/b/c for stations between 40 and 60 (ex: 60a)
Id_Station		Survey code + Station Number			"A1_N° Station" or "A2_N° Station" (ex: A1_01, "A2_49b)
Operation		Type of Operation				"BotTrawl" / "MESO" / "MICRO"
Operation_Code		Operation Identification			Survey_Operation_Station (ex: "A1_MICRO_01")
DateFull_mn		Date and Time					dd/MM/yyyy hh:mm
TimeStamp_mn		Number of seconds since 01/01/1970 00:0		Seconds
Latitude		Latitude					Decimal degrees
Longitude		Longitude					Decimal degrees
Bottom_Depth		Bottom Depth					meters
Dist_Shore		Shortest Distance from Continental Shoreline	meters
Fishing_Depth_Upper	Upper limit of the fishing haul			meters
Fishing_Depth_Lower	Lower limit of the fishing haul			meters
Start_Latitude		Start Latitude of haul				Decimal degrees
Start_Longitude		Start Longitude of haul				Decimal degrees
End_Latitude		End Latitude of haul				Decimal degrees
End_Longitude		End Longitude of haul				Decimal degrees
Start_Time		Start Time of haul				dd/MM/yyyy hh:mm
End_Time		End Time of haul				dd/MM/yyyy hh:mm
Fishing_Duration	Fishing Duration of haul			Seconds
Fishing_Distance	Fishing Distance of haul			meters
Cable_Length		Cable Length of haul				meters
Fishing_Speed		Fishing Speed of haul				knots
Horizontal_Opening	Horizontal Opening				meters
Vertical_Opening	Vertical opening				meters



3. Demersal_Deep_Pelagic_Biological_Data_Abracos1.csv
   Demersal_Deep_Pelagic_Biological_Data_Abracos2.csv
   
For each survey, these files describe the biological information collected for every organism.

After collection, the samples were divided according to the different biological compartments (macroalgae, sponges, gelatinous, molluscs, crustaceans, fish)
which were examined by different specialized laboratories for taxonomic identification and biological measurements.
The results were then compiled in a single file representing the whole community collected in the samples.
Consequently, the information given in this file can differ from one compartment to another.

The 13 first columns come from Demersal_Deep_Pelagic_Survey_Station_Abracos1.csv or Demersal_Deep_Pelagic_Survey_Station_Abracos2.csv.
They describe the fishing operations.

Columns 14, 15, 16 and the last 10 columns are from Demersal_Deep_Pelagic_Species_List_Abracos.csv. 
They describe the taxonomy of the individual.

Colums 17 to 34 give information on the considered taxa in the sample.

Column Name		Type of Data													Modalities / Units

Id_Survey		Survey Identification						"Abracos_1" / "Abracos_2"
Id_Survey_Pos		Chronological order of points					"A1_N° of line in the logbook"  / "A2_N° of line in the logbook"
Id_Station		Survey Code + Station Number					"A1_N° Station" or "A2_N° Station" (ex: A1_01, "A2_49b)
Operation		Type of Operation						"BotTrawl" / "MESO" / "MICRO"
Operation_Code		Operation Identification					Survey_Operation_Station (ex: "A1_MICRO_01")
DateFull_mn		Date and Time							dd/MM/yyyy hh:mm
TimeStamp_mn		Number of seconds since 01/01/1970 00:0				Seconds
Latitude		Latitude							Decimal degrees
Longitude		Longitude							Decimal degrees
Bottom_Depth		Bottom Depth							meters
Dist_Shore		Shortest Distance from Continental Shoreline			meters
Fishing_Depth_Upper	Upper limit of the fishing haul					meters
Fishing_Depth_Lower	Lower limit of the fishing haul					meters

Species			Taxonomic identification					Unique taxonomic identifier including "sp.", "sp. 1", "sp. nov. 1", etc. (ex: "Acanthostracion polygonium", "Abylopsis sp.")
Code_Species		Species code							First four letters of Genus and first four letters of Species, except if ambiguous (ex. "Acan.poly", "Abyl.sp", "Acanthephyra.quad")
Compartment		Minimum taxonomic compartment					"CRUS" (crustaceans) / "FISH" / "GELATINOUS" / "MACROALGAE" / "MOLL" (molluscs)/ "SPONGES"

Reg			Register of each individual of each species in the sample	1, 2, 3... or "ABxxx" (where xxx is a 3-digit number) or NaN
Pres_Abs		Presence /Absence modality					1 or NaN
Nb_Individual		Count of individuals						Number of individuals - Used for GELATINOUS family Salpidae (sol)
Nb_Colonies		Count of colonies						Number of colonies - Used for GELATINOUS family Salpidae (agg)
Biovolume		Biovolume							Number - Used for GELATINOUS (bv)
TL			Total Length							Used for FISH/CRUS/MOLL (Centimeters)
FL			Fork Length							Used for FISH (Centimeters)
SL			Standard Length							Used for FISH/CRUS/MOLL (Centimeters)
ML			Mantle Length 							Used for MOLL-Cephalopods and GELATINOUS-Hydrozoa (Centimeters) 
CL			Carapace Length							Used for CRUS (Centimeters)
DL			Disc Length							Used for rays (FISH/Dasyatidae & Rhinobatidae)(Centimeters)
TW			Total Weight							(Grams)
TWest			Total Weight estimated						Used for FISH and MOLL weighted in group(Grams)
EW			Eviscerated Weight						Used for FISH (Grams)
GonW			Gonad Weight							Used for FISH (Grams)
StomachW		Stomach Weight							Used for FISH (Grams)
Fullness		Fullness index (indicative of the species feeding intensity)	Used for FISH: "1" = Empty stomach; "2" = Partially empty; "3" = Partially full; "4" = Full stomach.
Collection		Rio museum collection number					Used for FISH: NPM+4 digits (ex : "NPM3162")

AphiaID_Worms		WoRMS AphiaID							Ex: 1577312 - NaN if not in WoRMS
Scientific_Name_Worms	Scientific name to search WoRMS					Similar to "Species" except sp, sp1, etc.(ex: "Acanthostracion polygonium", "Abylopsis") - Can be used to check the taxonomy with WoRMS
Authority_Worms		Authority = Descriptor of the species				Ex: (Rüppell, 1844), Chun, 1888
Kingdom			Kingdom								Animalia / Chromista / Plantae / NaN
Phylum			Phylum								Ex: Chordata
Class			Class								Ex: Teleostei
Order			Order								Ex: Tetraodontiformes
Family			Family								Ex: Ostracidae
Genus			Genus								Ex: Acanthostracion
rank			Identification level						Species / Genus / Family…
