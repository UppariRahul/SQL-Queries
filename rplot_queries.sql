-- MODULE : B9DA102 Data Storage Solutions for Data Analytics
-- GROUP B (Slot 4)

-- Subramaniam Kazhuparambil (10524303)
-- Rahul Ramchandra Uppari (10523807)
-- Deeksha Sharma (10522688) 
-- Mohit Singh (10525046)

-- QUERIES for creating Plots in R Studio --

-- R Studio ACRS Report Plot --

SELECT ACRSReportType, COUNT(CaseKey) AS No_of_Crashes
FROM CaseDetail_Dim
GROUP BY ACRSReportType
ORDER BY COUNT(CaseKey)

-- R Studio Driver Substance Abuse Plot --

SELECT Driver_Dim.DriverSubstanceAbuse, COUNT(*)CarCrashConditionsKey
FROM Driver_Dim 
INNER JOIN CrashAnalysis_Fact ON Driver_Dim.PersonKey = CrashAnalysis_Fact.PersonKey
GROUP BY Driver_Dim.DriverSubstanceAbuse
ORDER BY CarCrashConditionsKey
GO

-- R Studio Vehicle Type Plot --

SELECT VehicleBodyType, COUNT(VehicleKey) AS No_of_Crashes 
FROM Vehicle_Dim
GROUP BY VehicleBodyType
ORDER BY count(VehicleKey)
GO

-- R Studio Street type Plot -- 

SELECT ISNULL(StreetType, 'Unknown') AS StreetType, COUNT(*) CrashConditionsKey
FROM CrashConditions_Dim 
GROUP BY ISNULL(StreetType, 'Unknown')
ORDER BY COUNT(CrashConditionsKey) DESC
GO


