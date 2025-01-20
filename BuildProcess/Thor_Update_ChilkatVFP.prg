*File to control Thor CFU for application ChilkatVFP
lparameters;
	toUpdateObject

local;
	lcRepositoryURL    as string, ;
	lcDownloadsBranch  as string, ;
	lcDownloadsURL     as string, ;
	lcVersionFileURL   as string, ;
	lcZIPFileURL       as string, ;
	lcRegisterWithThor as string

* Get the URL for the version and ZIP files.

lcRepositoryURL   = 'https://github.com/billand88/ChilkatVFP'
	&& the URL for the project's repository
lcDownloadsBranch = 'main'
lcDownloadsURL    = strtran(m.lcRepositoryURL, 'github.com', ;
	'raw.githubusercontent.com') + '/' + m.lcDownloadsBranch + '/ThorUpdater/'
lcVersionFileURL  = m.lcDownloadsURL + 'ChilkatVFPVersion.txt' &&'ChilkatVFPVersion.txt'
	&& the URL for the file containing code to get the available version number
lcZIPFileURL      = m.lcDownloadsURL + 'ChilkatVFP.zip'
	&& the URL for the zip file containing the project


text to lcRegisterWithThor noshow textmerge
	messagebox('From the Thor menu, choose "More -> Open Folder -> Components" to see the folder where ChilkatVFP was installed', 0, 'ChilkatVFP Installed', 5000)
endtext

* Set the properties of the passed updater object.

with m.toUpdateObject
	.ApplicationName      = 'ChilkatVFP'
	.VersionLocalFilename = 'ChilkatVFPVersionFile.txt'
	.VersionFileURL       = m.lcVersionFileURL
	.SourceFileUrl        = m.lcZIPFileURL
	.Component            = 'No'
	.Link                 = m.lcRepositoryURL
	.LinkPrompt           = 'ChilkatVFP Home Page'
	.ProjectCreationDate  = date(2022, 09, 18)
	.Dependencies         = ''	&& a comma or space delimited list of other Thor applications (ApplicationName) that this project depends on
	.RegisterWithThor     = m.lcRegisterWithThor

endwith

return m.toUpdateObject

*created by VFPX Deployment, 12/28/2023 9:38:27 AM