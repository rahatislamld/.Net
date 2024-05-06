# Use the .NET SDK image as the build environment
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app
COPY . .
RUN dotnet publish -c Release -o out

# Use the ASP.NET runtime image for the final stage
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .
EXPOSE 80
CMD ["dotnet", "HelloWorldApp.dll"]
