# criar os diretório necessários, e no Linux liberar a permissão de leitura e escrita
# rodar o container pra criar instância do SQLServer e do Redis junto com a rede pra desenvolvimento

# development environment on Windows 
$dotnetPath = "C:\dev\dotnet-environment\dotnet"
$sqlPath = "C:\dev\dotnet-environment\mssql"
$redisPath = "C:\dev\dotnet-environment\redisdb"

# check dotnet path exists
Write-Host "Checking .NET Core directory!"
If (Test-Path -Path $dotnetPath) {
    Write-Host "Directory " $dotnetPath " already exists!"
} else {
    Write-Host "Creating .NET Core directory!" -ForegroundColor "Green"
    mkdir -p $dotnetPath
}

# check SQL Server path exists
Write-Host "Checking SQL Server directory!"
If (Test-Path -Path $sqlPath) {
    Write-Host "Directory " $sqlPath " already exists!" 
} else {
    Write-Host "Creating SQL Server directory!" -ForegroundColor "Green"
    mkdir -p $sqlPath
}

# check Redis path exists
Write-Host "Checking Redis directory!"
If (Test-Path -Path $redisPath) {
    Write-Host "Directory " $redisPath " already exists!" 
} else {
    Write-Host "Creating SQL Server directory!" -ForegroundColor "Green"
    mkdir -p $redisPath
}

# creating network dev
# docker network create --driver bridge dev-network

# criar os containers do SQL Server e do Redis
docker-compose up -d

# roda o comando para criar o container do dotnet
docker run  --name dotnet --rm --volume $dotnetPath":/srv/app" --workdir "/srv/app" --publish 5000:5000 -it --network dev-network mcr.microsoft.com/dotnet/sdk:3.1 bash
