#!/bin/sh

# run this script to up the containers to create an instance of SQL Server and Redis 
# together with the network for development
userLogged=$USER
YELLOW="\e[33m"
GREEN="\e[32m"
CYAN="\e[36m"
LIGHTYELLOW="\e[95m"
ENDCOLOR="\e[0m"
dotnetPath="/home/$userLogged/Dev/dotnet-environment/dotnet"
sqlPath="/home/$userLogged/Dev/dotnet-environment/mssql"
redisPath="/home/$userLogged/Dev/dotnet-environment/redisdb"

# check dotnet path exists
echo "${YELLOW}Checking .NET Core directory!${ENDCOLOR}" 
if [ -d $dotnetPath ]
then
    echo "${GREEN}OK${ENDCOLOR}"
else
    echo "${CYAN}Creating .NET Core directory!${ENDCOLOR}"
    mkdir -p $dotnetPath
    echo "${LIGHTYELLOW}Change recursive mode owner of .NET Core directory!${ENDCOLOR}"
    sudo chown -R $userLogged $dotnetPath
fi

# check SQL Server path exists
echo "${YELLOW}Checking SQL Server directory!${ENDCOLOR}" 
if [ -d $sqlPath ]
then
    echo "${GREEN}OK${ENDCOLOR}"
else
    echo "${CYAN}Creating SQL Server directory!${ENDCOLOR}"
    mkdir -p $sqlPath
    echo "${LIGHTYELLOW}Change recursive mode owner of SQL Server directory!${ENDCOLOR}"
    sudo chown -R $userLogged $sqlPath
fi

# check Redis path exists
echo "${YELLOW}Checking Redis directory!${ENDCOLOR}" 
if [ -d $redisPath ]
then
    echo "${GREEN}OK${ENDCOLOR}"
else
    echo "${CYAN}Creating Redis directory!${ENDCOLOR}"
    mkdir -p $redisPath
    echo "${LIGHTYELLOW}Change recursive mode owner of Redis directory!${ENDCOLOR}"
    sudo chown -R $userLogged $redisPath
fi

# create devlx-network
docker network create --driver bridge devlx-network

# create containers of SQL Server, RedisInsight and Redis
docker-compose up -d

# create container of .NET Core and connect on network-devlx network
docker run  --name dotnet --rm --volume $dotnetPath":/srv/app" --workdir "/srv/app" --publish 5000:5000 -it --network devlx-network mcr.microsoft.com/dotnet/sdk:3.1 bash
