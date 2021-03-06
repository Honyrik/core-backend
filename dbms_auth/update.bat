cd %~dp0
set PATHLIQUIBASE=liquibase
if exist liquibase\liquibase (
    set PATHLIQUIBASE=liquibase\liquibase
)
if exist ..\dbms\liquibase\liquibase (
    set PATHLIQUIBASE=..\dbms\liquibase\liquibase
)

call %PATHLIQUIBASE% --defaultsFile=liquibase.meta.properties --changeLogFile=db.changelog.meta.xml update >> main.log
call %PATHLIQUIBASE% --defaultsFile=liquibase.auth.properties --changeLogFile=db.changelog.auth.xml update >> main.log