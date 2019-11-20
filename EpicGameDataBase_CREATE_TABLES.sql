USE EpicGameDataBase;
GO

CREATE TABLE [dbo].[UserTable]
(
	[UserId] INT NOT NULL PRIMARY KEY IDENTITY, 
    [FirstName] NCHAR(20) NOT NULL, 
    [SecondName] NCHAR(20) NOT NULL, 
    [FullName] NCHAR(20) NOT NULL, 
    [PasswordHash] NCHAR(100) NULL, 
    [Nickname] NCHAR(50) NULL, 
    [Email] NCHAR(50) NULL
)

CREATE TABLE [dbo].[UserFriendsTable]
(
	[UserFriendId] INT NOT NULL PRIMARY KEY IDENTITY, 
	[UserId] INT NOT NULL,
    [FriendId] INT NOT NULL,
	CONSTRAINT [FK_UserFriendsTable_UserTable] FOREIGN KEY ([UserId]) REFERENCES [UserTable]([UserId])
)

CREATE TABLE [dbo].[UserFollowingTable]
(
	[UserFollowingId] INT NOT NULL PRIMARY KEY IDENTITY, 
	[UserId] INT NOT NULL,
    [FollowingId] INT NOT NULL,
	CONSTRAINT [FK_UserFollowingTable_UserTable] FOREIGN KEY ([UserId]) REFERENCES [UserTable]([UserId])
)

CREATE TABLE [dbo].[UserFollowersTable]
(
	[UserFollowersId] INT NOT NULL PRIMARY KEY IDENTITY, 
	[UserId] INT NOT NULL,
    [FollowerId] INT NOT NULL,
	CONSTRAINT [FK_UserFollowersTable_UserTable] FOREIGN KEY ([UserId]) REFERENCES [UserTable]([UserId])
)
CREATE TABLE [dbo].[GameUnitTypeTable]
(
	[GameUnitTypeId] INT NOT NULL PRIMARY KEY IDENTITY, 
    [GameUnitTypeName] NCHAR(40) NOT NULL
)

CREATE TABLE [dbo].[GameUnitsTable]
(
	[GameUnitId] INT NOT NULL PRIMARY KEY IDENTITY,
	[GameUnitType] INT NOT NULL,
	[GameUnitName] NCHAR(40) NOT NULL,
    [GameUnitHP] INT NOT NULL, 
    [GameUnitAttack] INT NOT NULL, 
    [GameUnitDefence] INT NOT NULL, 
    [GameUnitGoldIncome] INT NOT NULL, 
    [GameUnitGoldOutcome] INT NOT NULL,
	CONSTRAINT [FK_GameUnitsTable_GameUnitTypeTable] FOREIGN KEY ([GameUnitType]) REFERENCES [GameUnitTypeTable]([GameUnitTypeId])
)

CREATE TABLE [dbo].[GameBuildingTypeTable]
(
	[GameBuildingTypeId] INT NOT NULL PRIMARY KEY IDENTITY, 
    [GameBuildingTypeName] NCHAR(20) NOT NULL
)
CREATE TABLE [dbo].[GameBuildingsTable]
(
	[GameBuildingId] INT NOT NULL PRIMARY KEY IDENTITY, 
    [GameBuildingType] INT NOT NULL, 
	[GameBuildingName] NCHAR(40) NOT NULL,
    [GameBuildingHP] INT NOT NULL, 
    [GameBuildingAttack] INT NOT NULL, 
    [GameBuildingDefence] INT NOT NULL, 
    [GameBuildingGoldIncome] INT NOT NULL, 
    [GameBuildingGoldOutcome] INT NOT NULL, 
    [Capacity] INT NOT NULL,
	CONSTRAINT [FK_GameBuildingsTable_GameBuildingTypeTable] FOREIGN KEY ([GameBuildingType]) REFERENCES [GameBuildingTypeTable]([GameBuildingTypeId])
)

CREATE TABLE [dbo].[SessionMapTable]
(
	[SessionMapId] INT NOT NULL PRIMARY KEY IDENTITY,
	[XCoord] DECIMAL(18, 2) NOT NULL,
	[YCoord] DECIMAL(18, 2) NOT NULL
)

CREATE TABLE [dbo].[SessionCoresTable]
(
	[SessionCoreId] INT NOT NULL PRIMARY KEY IDENTITY, 
    [UserId] INT NOT NULL,
	[CoreMapId] INT NOT NULL,
	[Money] INT NOT NULL,
	CONSTRAINT [FK_SessionCoresTable_UserTable] FOREIGN KEY ([UserId]) REFERENCES [UserTable]([UserId]),
    CONSTRAINT [FK_SessionCoresTable_SessionMapTable] FOREIGN KEY ([CoreMapId]) REFERENCES [SessionMapTable]([SessionMapId]) 
)

CREATE TABLE [dbo].[SessionBasesTable]
(
	[SessionBaseId] INT NOT NULL PRIMARY KEY IDENTITY,
	[SessionCoreId] INT NOT NULL,
	[BuildingLevel] INT NOT NULL,
	[WorkersNumber] INT NOT NULL,
	[UniqueUpgrade] INT NOT NULL,
	[AttackUpgrade] INT NOT NULL,
	[DefenceUpgrade] INT NOT NULL,
	[CapacityUpgrade] INT NOT NULL,
	CONSTRAINT [FK_SessionBasesTable_SessionCoresTable] FOREIGN KEY ([SessionCoreId]) REFERENCES [SessionCoresTable]([SessionCoreId])
)

CREATE TABLE [dbo].[SessionCasernsTable]
(
	[SessionCasernId] INT NOT NULL PRIMARY KEY IDENTITY,
	[SessionCoreId] INT NOT NULL,
	[BuildingLevel] INT NOT NULL,
	[WarriorsNumber] INT NOT NULL, 
    [AttackAircraftNumber] INT NOT NULL, 
	[UniqueUpgrade] INT NOT NULL,
	[CapacityUpgrade] INT NOT NULL,
	CONSTRAINT [FK_SessionCasernsTable_SessionCoresTable] FOREIGN KEY ([SessionCoreId]) REFERENCES [SessionCoresTable]([SessionCoreId])
)

CREATE TABLE [dbo].[SessionDefenceTowersTable]
(
	[SessionDefenceTowerId] INT NOT NULL PRIMARY KEY IDENTITY,
	[SessionCoreId] INT NOT NULL,
	[BuildingLevel] INT NOT NULL,
	[UniqueUpgrade] INT NOT NULL,
	[AttackUpgrade] INT NOT NULL,
	[DefenceUpgrade] INT NOT NULL,
	CONSTRAINT [FK_SessionDefenceTowersTable_SessionCoresTable] FOREIGN KEY ([SessionCoreId]) REFERENCES [SessionCoresTable]([SessionCoreId])
)

CREATE TABLE [dbo].[SessionGoldMiningsTable]
(
	[SessionGoldMiningId] INT NOT NULL PRIMARY KEY IDENTITY,
	[SessionCoreId] INT NOT NULL,
	[BuildingLevel] INT NOT NULL,
	[WorkersNumber] INT NOT NULL,
	[UniqueUpgrade] INT NOT NULL,
	[CapacityUpgrade] INT NOT NULL,
	CONSTRAINT [FK_SessionGoldMiningsTable_SessionCoresTable] FOREIGN KEY ([SessionCoreId]) REFERENCES [SessionCoresTable]([SessionCoreId])
	
)

CREATE TABLE [dbo].[SessionStatisticTable]
(
	[SessionStatisticId] INT NOT NULL PRIMARY KEY IDENTITY,
	[SessionCoreId] INT NOT NULL,
	[Rating] INT NOT NULL,
	[Wins] INT NOT NULL,
	[Defeats] INT NOT NULL,
	[SuccessfullCoreAttacks] INT NOT NULL,
	[NotSuccessfullCoreAttacks] INT NOT NULL,
	[Scores] INT NOT NULL,
	CONSTRAINT [FK_SessionStatisticTable_SessionCoresTable] FOREIGN KEY ([SessionCoreId]) REFERENCES [SessionCoresTable]([SessionCoreId])
)