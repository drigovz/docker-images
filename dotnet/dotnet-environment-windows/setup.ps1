# criar os diretório necessários, e no Linux liberar a permissão de leitura e escrita
# rodar o container pra criar instância do SQLServer e do Redis junto com a rede pra desenvolvimento

# development environment on Windows 
$dotnetPath = "C:\dev\dotnet-environment\dotnet"

If (Test-Path -Path $dotnetPath) {
    Write-Host "Directory " $dotnetPath " already exists!" -ForegroundColor "Green"
} else {
    Write-Host "Creating directory!"
    mkdir -p C:\dev\dotnet-environment
}

# criar os containers do SQL Server e do Redis

# roda o comando para criar o container do dotnet
docker run --rm --volume $dotnetPath":/srv/app" --workdir "/srv/app" --publish 5000:5000 -it mcr.microsoft.com/dotnet/sdk:3.1 bash
