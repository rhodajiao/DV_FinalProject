aggData <- merge(breast_female_mortality, breast_female_incidence, by=c("COUNTRY", "YEAR")) %>% merge(cervix_female_mortality, by=c("COUNTRY", "YEAR")) %>% merge(cervix_female_incidence, by=c("COUNTRY", "YEAR")) %>% merge(colon_female_mortality, by=c("COUNTRY", "YEAR")) %>% merge(colon_female_incidence, by=c("COUNTRY", "YEAR")) %>% merge(colon_male_mortality, by=c("COUNTRY", "YEAR")) %>% merge(colon_male_incidence, by=c("COUNTRY", "YEAR")) %>% merge(liver_female_mortality, by=c("COUNTRY", "YEAR")) %>% merge(liver_female_incidence, by=c("COUNTRY", "YEAR")) %>% merge(liver_male_mortality, by=c("COUNTRY", "YEAR")) %>% merge(liver_male_incidence, by=c("COUNTRY", "YEAR")) %>% merge(lung_female_mortality, by=c("COUNTRY", "YEAR")) %>% merge(lung_female_incidence, by=c("COUNTRY", "YEAR")) %>% merge(lung_male_mortality, by=c("COUNTRY", "YEAR")) %>% merge(lung_male_incidence, by=c("COUNTRY", "YEAR")) %>% merge(prostate_male_mortality, by=c("COUNTRY", "YEAR")) %>% merge(prostate_male_incidence, by=c("COUNTRY", "YEAR")) %>% merge(stomach_female_mortality, by=c("COUNTRY", "YEAR")) %>% merge(stomach_female_incidence, by=c("COUNTRY", "YEAR")) %>% merge(stomach_male_mortality, by=c("COUNTRY", "YEAR")) %>% merge(stomach_male_incidence, by=c("COUNTRY", "YEAR")) %>% merge(life_expectancy, by=c("COUNTRY", "YEAR")) %>% merge(gdpbreakdown, by=c("COUNTRY")) %>% merge(hdi, by=c("COUNTRY")) %>% merge(continents,by=c("COUNTRY"))
print(tbl_df(aggData))

# Get the ratio of male to female liver cancer mortalities across all countries
MaleFemaleLiverMortalityPlotTEMP <- left_join(liver_female_mortality,liver_male_mortality,by="COUNTRY") %>% filter(YEAR.x==2002 & YEAR.y==2002) %>% mutate(LIVER_MALE_MORTALITY/LIVER_FEMALE_MORTALITY)
MaleFemaleLiverMortalityPlot <- left_join(continents,MaleFemaleLiverMortalityPlotTEMP,by="COUNTRY") %>% filter(!is.na(LIVER_MALE_MORTALITY/LIVER_FEMALE_MORTALITY))

# Get the ratio of male to female lung cancer mortalities across all countries
MaleFemaleLungMortalityPlotTEMP <- left_join(lung_female_mortality,lung_male_mortality,by="COUNTRY") %>% filter(YEAR.x==2002 & YEAR.y==2002) %>% mutate(LUNG_MALE_MORTALITY/LUNG_FEMALE_MORTALITY)
MaleFemaleLungMortalityPlot <- left_join(continents,MaleFemaleLungMortalityPlotTEMP,by="COUNTRY") %>% filter(!is.na(LUNG_MALE_MORTALITY/LUNG_FEMALE_MORTALITY))

# Get the ratio of male to female colon cancer mortalities across all countries
MaleFemaleColonMortalityPlotTEMP <- left_join(colon_female_mortality,colon_male_mortality,by="COUNTRY") %>% filter(YEAR.x==2002 & YEAR.y==2002) %>% mutate(COLON_MALE_MORTALITY/COLON_FEMALE_MORTALITY)
MaleFemaleColonMortalityPlot <- left_join(continents,MaleFemaleColonMortalityPlotTEMP,by="COUNTRY") %>% filter(!is.na(COLON_MALE_MORTALITY/COLON_FEMALE_MORTALITY))

aggDataFiltered <- aggData %>% arrange(HDINUMBER)

## Gathering each incidence and mortality rate into it's own type

tempData <- aggData %>% filter(YEAR == 2002) %>% select(COUNTRY:LIFE_EXPECTANCY, HDINUMBER, HDICATEGORY, CONTINENT) 
colnames(tempData) <- c("COUNTRY", "YEAR", "F BREAST", "a", "F CERVICAL", "b", "F COLON", "c", "M COLON", "d", "F LIVER", "e", "M LIVER", "f", "F LUNG", "g", "M LUNG", "h", "M PROSTATE", "i", "F STOMACH", "j", "M STOMACH", "k", "LIFE_EXPECTANCY", "HDI_NUMBER", "HDI_CATEGORY","CONTINENT")
Mortality <- tempData %>% gather("TYPE", "Mortality", c(3,5,7,9,11,13,15,17,19,21,23)) %>% select(COUNTRY, TYPE, Mortality, CONTINENT) %>% arrange(COUNTRY)
tempData1 <- aggData %>% filter(YEAR == 2002) %>% select(COUNTRY:LIFE_EXPECTANCY, HDINUMBER, HDICATEGORY, CONTINENT)
colnames(tempData1) <- c("COUNTRY", "YEAR", "l", "F BREAST", "a", "F CERVICAL", "b", "F COLON", "c", "M COLON", "d", "F LIVER", "e", "M LIVER", "f", "F LUNG", "g", "M LUNG", "h", "M PROSTATE", "i", "F STOMACH", "j", "M STOMACH", "LIFE_EXPECTANCY", "HDI_NUMBER", "HDI_CATEGORY", "CONTINENT")
Incidence <- tempData1 %>% filter(YEAR == 2002) %>% gather("TYPE", "Incidence", c(4,6,8,10,12,14,16,18,20,22,24)) %>% select(COUNTRY, TYPE, HDI_NUMBER, HDI_CATEGORY, Incidence, CONTINENT, LIFE_EXPECTANCY) %>% arrange(COUNTRY)
MortalIncidence <- merge(Mortality, Incidence, by=c("CONTINENT", "COUNTRY", "TYPE"))
