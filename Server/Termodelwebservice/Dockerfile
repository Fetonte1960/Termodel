FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY Directory.Build.props ./
COPY src/Termodel.Core/Termodel.Core.csproj src/Termodel.Core/
COPY src/Termodel.WebService/Termodel.WebService.csproj src/Termodel.WebService/
RUN dotnet restore src/Termodel.WebService/Termodel.WebService.csproj

COPY . .
RUN dotnet publish src/Termodel.WebService/Termodel.WebService.csproj \
    -c Release \
    -o /app/publish \
    --no-restore \
    /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

COPY --from=build /app/publish .

ENV ASPNETCORE_ENVIRONMENT=Production
EXPOSE 10000

CMD ["sh", "-c", "ASPNETCORE_URLS=http://0.0.0.0:${PORT:-10000} exec dotnet Termodel.WebService.dll"]
