%% EuropeWeather Project
set(gcf,'renderer','opengl')
%
%% Initialise data from netCDF file
ncdisp('o3_surface_20180701000000.nc') % outputs variables to console
ncfile = 'o3_surface_20180701000000.nc'; 
long = ncread(ncfile,'lon'); nx = length(long) ;
lat = ncread(ncfile,'lat'); ny = length(lat) ;
time = ncread(ncfile,'hour'); nt = length(time) ;
ozone = ncread(ncfile,'eurad_ozone'); % Takes Ozone data

%% Plots netCDF data
for i = 1:nt
    pcolor(X,Y,ozone(:,:,i)') ;    
    title(sprintf('time = %f',time(i)))
    shading interp ;
    pause(.1)
end

%% Create a Map of Europe
[X,Y] = meshgrid(long, lat);
europe = worldmap('Europe'); % Sets Europe as Target
getm(europe,'MapProjection')
geoshow('landareas.shp', 'FaceColor', [0.15 0.5 0.15])
geoshow('worldlakes.shp', 'FaceColor', 'blue')
geoshow('worldrivers.shp', 'Color', 'blue')
geoshow('worldcities.shp', 'Marker', '.',...
                           'MarkerEdgeColor', 'red');

