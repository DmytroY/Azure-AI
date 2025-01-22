@echo off

rem This is original part for set values for your Search service, but we will use .env file
@REM set url=YOUR_SEARCH_URL
@REM set admin_key=YOUR_ADMIN_KEY

rem Load environment variables from .env file, namely here we need SEARCH_URL and SEARCH_ADMIN_KEY
for /f "tokens=1,2 delims==" %%a in ('type .env') do set %%a=%%b

echo -----
echo Creating the data source...
call curl -X POST %SEARCH_URL%/datasources?api-version=2020-06-30 -H "Content-Type: application/json" -H "api-key: %SEARCH_ADMIN_KEY%" -d @data_source.json

echo -----
echo Creating the skillset...
call curl -X PUT %SEARCH_URL%/skillsets/margies-custom-skillset?api-version=2020-06-30 -H "Content-Type: application/json" -H "api-key: %SEARCH_ADMIN_KEY%" -d @skillset.json

echo -----
echo Creating the index...
call curl -X PUT %SEARCH_URL%/indexes/margies-custom-index?api-version=2020-06-30 -H "Content-Type: application/json" -H "api-key: %SEARCH_ADMIN_KEY%" -d @index.json

rem wait
timeout /t 3 /nobreak

echo -----
echo Creating the indexer...
call curl -X PUT %SEARCH_URL%/indexers/margies-custom-indexer?api-version=2020-06-30 -H "Content-Type: application/json" -H "api-key: %SEARCH_ADMIN_KEY%" -d @indexer.json
