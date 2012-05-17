%This file will download and unzip all SRTM3 files on the usgs website
%It will only get the North America. Change urlPrefix to get others
%The N and W ranges can be set accordingly to save time

urlPrefix='http://dds.cr.usgs.gov/srtm/version2_1/SRTM3/North_America/';
for N=[55:60]
	for W=0:180
		if W<10
			[f,status]=urlwrite([urlPrefix 'N' num2str(N) 'W00' num2str(W) 'hgt.zip'],['N' num2str(N) 'W00' num2str(W) 'hgt.zip']);
            if status ~= 0
                unzip(['N' num2str(N) 'W00' num2str(W) 'hgt.zip']);
            end
		elseif W<100
			[f,status]=urlwrite([urlPrefix 'N' num2str(N) 'W0' num2str(W) 'hgt.zip'],['N' num2str(N) 'W0' num2str(W) 'hgt.zip']);
            if status ~= 0
            unzip(['N' num2str(N) 'W0' num2str(W) 'hgt.zip']);
            end
        else	
			[f,status]=urlwrite([urlPrefix 'N' num2str(N) 'W' num2str(W) 'hgt.zip'],['N' num2str(N) 'W' num2str(W) 'hgt.zip']);
            if status ~= 0
            unzip(['N' num2str(N) 'W' num2str(W) 'hgt.zip']);
            end
		end
	end
end