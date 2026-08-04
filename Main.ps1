$APIKEY = "YOURAPIKEYHERE"
$DESCSAVEPATH = "YOURDESCRIPTIONSAVEPATHHERE"
$IMAGEPATH = "YOURIMAGESAVEPATHHERE"


$url = "https://api.nasa.gov/planetary/apod?api_key=$APIKEY"
$Response = Invoke-WebRequest -UseBasicParsing -Method 'GET' -Uri $url
$object = $Response.Content | ConvertFrom-Json

## parse the output
$explanation = $object."explanation"
$title = $object."title"
$imgUrl = $object."url"
$date = $object.date
$type = $object."media_type"


if ($type -eq "image")
{
    #save description text
    ("$title`n") + ("$date`n") + (($Explanation -split '\. ') -join "`n") | Out-File $DESCSAVEPATH

    $path = $IMAGEPATH
    $imgName = "$date.jpg"

    $fullPath = Join-Path $path $imgName


    ##save the image
    Invoke-WebRequest -UseBasicParsing -outfile $fullPath -Uri $imgUrl

    ##set the image
    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class Wallpaper {
        [DllImport("user32.dll")]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
"@
    [Wallpaper]::SystemParametersInfo(20, 0, $fullPath, 3)
}
else
{
    Write-Warning "object type is not an image"
}