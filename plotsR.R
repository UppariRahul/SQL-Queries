## MODULE : B9DA102 Data Storage Solutions for Data Analytics
## GROUP B (Slot 4)

## Subramaniam Kazhuparambil (10524303)
## Rahul Ramchandra Uppari (10523807)
## Deeksha Sharma (10522688) 
## Mohit Singh (10525046)

## Visualisation with R

library(odbc)
sort(unique(odbcListDrivers()[[1]]))

conn <- dbConnect(odbc(), 
                  Driver = "SQL Server", 
                  Server = "SUBUNAIRFBED", 
                  Database = "carCrashDW", 
                  Trusted_Connection = "True")
conn


################ GRAPH 1 (Street type) ################

streetData <- dbGetQuery(conn, "SELECT ISNULL(StreetType, 'Unknown') AS StreetType, COUNT(*) CrashConditionsKey
                                FROM CrashConditions_Dim 
                                GROUP BY ISNULL(StreetType, 'Unknown')
                                ORDER BY COUNT(CrashConditionsKey) DESC")
streetData


par(las = 2, mar = c(5, 5.5, 4, 2))
color_range <- c( redpink = "#FF6666", orange = "#E69F00", skyblue = "#56B4E9", bluegreen = "#009E73", 
                 yellow = "#F0E442", blue = "#0072B2", reddish = "#D55E00", purplish = "#CC79A7",
                 green = "#99FF33", black = "#000000")


streetPlot <- barplot(streetData[, "CrashConditionsKey"], 
               main = "Car Crash incidents on different types of streets (2015-2019)", 
               xlab = "No. of Crashes",
               xlim = c(0, 30000),
               horiz = TRUE,
               names.arg = c(streetData[, "StreetType"]),
               col = color_range,
               cex.axis = 0.8,
               cex.names = 0.5)

text(x = streetData$CrashConditionsKey, y = streetPlot, label = streetData$CrashConditionsKey, 
     pos = 4, cex = 0.8, col = "black")

################ GRAPH 2 (Top 10 types of Vehicles involved in car crashes) ################

vehicleData <- dbGetQuery(conn, "SELECT VehicleBodyType, COUNT(VehicleKey) AS No_of_Crashes 
                                 FROM Vehicle_Dim
                                 GROUP BY VehicleBodyType
                                 ORDER BY count(VehicleKey)")

vehicleData[26, 2]
vehicleData[10, 2]
vehicleData[18, 2] <- vehicleData[18, 2] + vehicleData[10, 2] + vehicleData[26, 2]
vehicleData[18, 2]
vehicleData <- vehicleData[-26, ]
vehicleData <- vehicleData[-10, ]

## Line of Code 57-62 are used to combine N A, N/A and Unknown Values into one row

plotData <- vehicleData[-c(1:20),]

par(las = 2, mar = c(5, 11, 4, 2))
color_range <- c( redpink = "#FF6666", orange = "#E69F00", skyblue = "#56B4E9", bluegreen = "#009E73", 
                  yellow = "#F0E442", blue = "#0072B2", reddish = "#D55E00", purplish = "#CC79A7",
                  green = "#99FF33", black = "#000000")


vehiclePlot <- barplot(plotData[, "No_of_Crashes"], 
                      main = "Top 10 type of Vehicles involved in Car Crashes (2015-2019)", 
                      xlab = "No. of Crashes",
                      xlim = c(0, 42000),
                      horiz = TRUE,
                      names.arg = c(plotData[, "VehicleBodyType"]),
                      col = color_range,
                      cex.axis = 0.8,
                      cex.names = 0.4)

text(x = plotData$No_of_Crashes, y = vehiclePlot, label = plotData$No_of_Crashes, pos = 4, cex = 0.8, col = "black")

################ GRAPH 3 (Types of Driver Substance Abuse) ################

saData <- dbGetQuery(conn, "SELECT Driver_Dim.DriverSubstanceAbuse, COUNT(*)CarCrashConditionsKey
                            FROM Driver_Dim 
                            INNER JOIN CrashAnalysis_Fact ON Driver_Dim.PersonKey = CrashAnalysis_Fact.PersonKey
                            GROUP BY Driver_Dim.DriverSubstanceAbuse
                            ORDER BY CarCrashConditionsKey")
saData

saData[10, 2] <- saData[10, 2] + saData[11, 2]
saData <- saData[-11,]
saData

par(las = 2, mar = c(5, 8, 4, 2))
color_range <- c( redpink = "#FF6666", orange = "#E69F00", skyblue = "#56B4E9", bluegreen = "#009E73", 
                  yellow = "#F0E442", blue = "#0072B2", reddish = "#D55E00", purplish = "#CC79A7",
                  green = "#99FF33", black = "#000000")


saPlot <- barplot(saData[, "CarCrashConditionsKey"], 
                       main = "Types of Substance Abuse contributing to car crashes (2015-2019)", 
                       xlab = "No. of Crashes",
                       xlim = c(0, 42000),
                       horiz = TRUE,
                       names.arg = c(saData[, "DriverSubstanceAbuse"]),
                       col = color_range,
                       cex.axis = 0.8,
                       cex.names = 0.5)

text(x = saData$CarCrashConditionsKey, y = saPlot, label = saData$CarCrashConditionsKey, pos = 4, cex = 0.8, col = "black")

################ GRAPH 4 (ACRS Report Type) ################

acrsData <- dbGetQuery(conn, "SELECT ACRSReportType, COUNT(CaseKey) AS No_of_Crashes 
                              FROM CaseDetail_Dim
                              GROUP BY ACRSReportType
                              ORDER BY count(CaseKey)")
acrsData

par(las = 2, mar = c(5, 8, 4, 2))
color_range <- c( redpink = "#FF6666", orange = "#E69F00", skyblue = "#56B4E9", bluegreen = "#009E73", 
                  yellow = "#F0E442", blue = "#0072B2", reddish = "#D55E00", purplish = "#CC79A7",
                  green = "#99FF33", black = "#000000")


acrsPlot <- barplot(acrsData[, "No_of_Crashes"], 
                  main = "ACRS (Automated Crash Reporting System) Report type (2015-2019)", 
                  xlab = "No. of Crashes",
                  xlim = c(0, 40000),
                  horiz = TRUE,
                  names.arg = c(acrsData[, "ACRSReportType"]),
                  col = color_range,
                  cex.axis = 0.8,
                  cex.names = 0.7)

text(x = acrsData$No_of_Crashes, y = acrsPlot, label = acrsData$No_of_Crashes, pos = 4, cex = 0.8, col = "black")




