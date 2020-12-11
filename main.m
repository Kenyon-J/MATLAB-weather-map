%% EuropeWeather Project
close all % closes all figures
clc
set(gcf,'renderer','opengl') % ensures opengl renderer, should be default
%
%% Initialise data from netCDF file
% ncdisp('o3_surface_20180701000000.nc') % outputs variables to console ...
% (Bug testing)
ncfile = 'o3_surface_20180701000000.nc'; 
%Longitude and length
long = ncread(ncfile,'lon'); nx = length(long) ;
%Latitude and length
lat = ncread(ncfile,'lat'); ny = length(lat) ;
%Time by hour
time = ncread(ncfile,'hour'); nt = length(time) ;
%Convert long and lat to doubles
long=double(long);
lat=double(lat);

%% Select data model and map colours
%Selecting the data type
disp('Select data model: ');
model=input(['1: chimere \n2: emep \n3: ensemble',...
            '\n4: eurad \n5: lotoseuros \n6: match',...
            '\n7: mocage \n8: silam \n']);

%Reads data from choice input
if model==1
data = ncread(FileNC,'chimere_ozone') ;
elseif model==2
data = ncread(FileNC,'emep_ozone') ;    
elseif model==3
data = ncread(FileNC,'ensemble_ozone') ;    
elseif model==4
data = ncread(FileNC,'eurad_ozone') ;    
elseif model==5
data = ncread(FileNC,'lotoseuros_ozone') ;    
elseif model==6
data = ncread(FileNC,'match_ozone') ;    
elseif model==7
data = ncread(FileNC,'mocage_ozone') ;    
elseif model==8
data = ncread(FileNC,'silam_ozone') ;   
    
end% user interface - allows the user to select an option to their needs
disp('Please select your desired colour format: ')
userInput = ('a: Standard Display\nb: High Contrast mode \n');
mapColour = input(userInput,'s');

%% Create map of Europe
if (mapColour == 'a' || mapColour == 'A')
    for i = 1:24 %24 hour loop     
    % Centres map on Europe
    worldmap('Europe');
    % Plot coast outlines
    load coastlines
    plotm(coastlat,coastlon);
    % Plot land
    land = shaperead('landareas', 'UseGeoCoords', true);
    geoshow(gca, land, 'FaceColor', [0.8 0.8 0.8]);
    % Plot lakes
    lakes = shaperead('worldlakes', 'UseGeoCoords', true);
    geoshow(lakes, 'FaceColor', 'blue'); 
    % Plot rivers
    rivers = shaperead('worldrivers', 'UseGeoCoords', true);
    geoshow(rivers, 'Color', 'blue'); 
    % Plot cities
    cities = shaperead('worldcities', 'UseGeoCoords', true);
    geoshow(cities, 'Marker', '.', 'Color', 'red');
   
    % Plots the data and sets transparency and edges
    surfm(X, Y, data(:,:,i)', 'EdgeColor', 'none',...
        'FaceAlpha', 0.5); %data overlay Transparency 
    %Default colours
    colormap default;
    % Sets colorbar label and position
    cbar = colorbar('northoutside');
    cbar.Label.String = 'Ozone by PPM';
    title(sprintf("UTC : Hour " + i + "\n" ));
    pause(0.1); % iterates through time intervals 
    end
% High contrast map    
elseif (mapColour == 'b' || mapColour == 'B')
   for i = 1:24 %24H loop
    % Centres map on Europe
    worldmap('Europe');
    % Plot coast outlines
    load coastlines
    plotm(coastlat,coastlon);
    % Plot land
    land = shaperead('landareas', 'UseGeoCoords', true);
    geoshow(gca, land, 'FaceColor', [0.5 0.5 0.5]);
    % Plot lakes   
    lakes = shaperead('worldlakes', 'UseGeoCoords', true); 
    geoshow(lakes, 'FaceColor', 'blue'); 
    % Plot rivers
    rivers = shaperead('worldrivers', 'UseGeoCoords', true); 
    geoshow(rivers, 'Color', 'blue');
    % Plot cities
    cities = shaperead('worldcities', 'UseGeoCoords', true);
    geoshow(cities, 'Marker', '.', 'Color', 'black');

    % Plot the data
    surfm(X, Y, data(:,:,i), 'EdgeColor', 'none',...
        'FaceAlpha', 0.7) % data overlay Transparency
    colormap Jet ; % High Contrast Colours
    % Sets colorbar label and position
    cbar = colorbar('northoutside');
    cbar.Label.String = 'Ozone by PPM';
    title(sprintf("UTC : Hour " + i + "\n" ))
    pause(0.1) % iterates through time intervals
    end 
   
else 
    %Escape message
    disp('Invalid')
    
end
