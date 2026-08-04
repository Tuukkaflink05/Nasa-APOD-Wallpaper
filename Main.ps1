$APIKEY = "YOURAPIKEYHERE"
$DESCSAVEPATH = "YOURDESCRIPTIONSAVEPATHHERE"
$IMAGESAVEPATH = "YOURIMAGESAVEPATHHERE"

#sets desktop wallpaper to the image from the path given
function Set-Wallpaper {
    param (
        [parameter(Mandatory)]
        [string]$ImgPath
    )

    ##set the image
    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class Wallpaper {
        [DllImport("user32.dll")]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
"@
    [Wallpaper]::SystemParametersInfo(20, 0, $ImgPath, 3)

}

$url = "https://api.nasa.gov/planetary/apod?api_key=$APIKEY"

try {
    $Response = Invoke-WebRequest -UseBasicParsing -Method 'GET' -Uri $url
} catch {
    $StatusCode = $_.Exception.Response.StatusCode.value__
    Write-Warning "Web request failed with code: $StatusCode"
    Write-Output "Exiting"
    exit 1
}

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

    $path = $IMAGESAVEPATH
    $imgName = "$date.jpg"

    $fullPath = Join-Path $path $imgName

    ##save the image
    Invoke-WebRequest -UseBasicParsing -outfile $fullPath -Uri $imgUrl

    Set-Wallpaper -ImgPath $fullPath
}
else {
    #TODO: do something when the image is not an image and when the request fails
    Write-Warning "object type is not an image"
}