# Etapa de compilación
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Copia los archivos .csproj y restaura dependencias
COPY *.csproj ./
RUN dotnet restore

# Copia todo lo demás y compila
COPY . ./
RUN dotnet publish -c Release -o out

# Etapa de ejecución
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .

# Expone el puerto por defecto (puedes cambiarlo si usas otro)
EXPOSE 80

# Comando de ejecución
ENTRYPOINT ["dotnet", "Chatbot WhatsApp Cobranza.dll"]
