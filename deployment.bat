@echo off

git clone https://github.com/VladimirEfremov/EpicGame

cd EpicGame/EpicGameWeb/Client

npm install

ng build

cd ../../..

sqlcmd -S "(localdb)\MSSQLLocalDB" -i "EpicGameDataBase_CREATE.sql"
sqlcmd -S "(localdb)\MSSQLLocalDB" -i "EpicGameDataBase_CREATE_TABLES.sql"
sqlcmd -S "(localdb)\MSSQLLocalDB" -i "EpicGameDataBase_DATA_CREATE.sql"

pause


 