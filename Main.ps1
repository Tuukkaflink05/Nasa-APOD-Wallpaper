$APIKEY = "YOUR-API-KEY-HERE"
$DESCSAVEPATH = "YOUR-DESCRIPTION-SAVE-PATH-HERE"
$IMAGESAVEPATH = "YOUR-IMAGE-SAVE-PATH-HERE"

#sets desktop wallpaper to the image from the path given
function Set-Wallpaper {
    param (
        [parameter(Mandatory)]
        [string]$ImgPath
    )

    ##set the image
    if (-not ("Wallpaper" -as [type])) {
    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class Wallpaper {
        [DllImport("user32.dll")]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
"@
    }

    [Wallpaper]::SystemParametersInfo(20, 0, $ImgPath, 3)

    Write-Output "Image set"
    exit 0
}

#attempts to get a random image from the ImageSave path specified
function Get-RandomImg {
    Write-Output "Finding Random image"
    $allImgs = Get-ChildItem -Path $IMAGESAVEPATH  *.jpg -Name

    if ($null -eq $allImgs) {
        Write-Output "no Image found"
        exit 2
    }

    $randomImg = $allImgs | Get-Random
    $fullPath = Join-Path $IMAGESAVEPATH $randomImg

    Set-Wallpaper -ImgPath $fullPath

}

$url = "https://api.nasa.gov/planetary/apod?api_key=$APIKEY"

try {
    $Response = Invoke-WebRequest -UseBasicParsing -Method 'GET' -Uri $url
} catch {
    $StatusCode = $_.Exception.Response.StatusCode.value__
    $errorMsg = "Web request failed with code: $StatusCode"
    Write-Warning  $errorMsg
    Write-Output "Error saved to description file"
    $errorMsg | Out-File $DESCSAVEPATH

    Get-RandomImg
}

$object = $Response.Content | ConvertFrom-Json

## parse the output
$explanation = $object."explanation"
$title = $object."title"
$imgUrl = $object."url"
$hdImgUrl = $object."hdurl"
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
    #if hd image url is not null try to save the hd image else save normal image
    if ($null -ne $hdImgUrl) {
        Invoke-WebRequest -UseBasicParsing -outfile $fullPath -Uri $hdImgUrl
    } else {
        Invoke-WebRequest -UseBasicParsing -outfile $fullPath -Uri $imgUrl
    }

    Set-Wallpaper -ImgPath $fullPath
}
else {
    Write-Warning "object type is not an image"
    Get-RandomImg
}
