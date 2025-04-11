# Etapa de compilación
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Copia el archivo .csproj y restaura dependencias
COPY "Chatbot WhatsApp Cobranza.csproj" ./
RUN dotnet restore "Chatbot WhatsApp Cobranza.csproj"

# Copia el resto de archivos y compila
COPY . ./
RUN dotnet publish "Chatbot WhatsApp Cobranza.csproj" -c Release -o out

# Etapa de ejecución
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .

# Expone el puerto por defecto
EXPOSE 80

# Comando de ejecución
ENTRYPOINT ["dotnet", "Chatbot WhatsApp Cobranza.dll"]
