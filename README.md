# Nasa-APOD-Wallpaper
### Fetch the Nasa Astronomy Picture of the Day and set it as Windows wallpaper

- uses powershell commands to fetch, save, and set the Nasa astronomy picture of the day as your wallpaper.

## Requirements
- Nasa api key
    - Generate a key from [api.nasa.gov](https://api.nasa.gov/)
- Windows 10/11

## How to use
### Clone the repository

```
git clone https://github.com/Tuukkaflink05/Nasa-APOD-Wallpaper
```

### Change into the new directory

```
cd Nasa-APOD-Wallpaper
```

### Open the Main.ps1 file and change placeholder values:
- 'YOUR-API-KEY-HERE'
    - with your nasa api key

- 'YOUR-DESCRIPTION-SAVE-PATH-HERE'
    - With the path you want to save the description of the image

- 'YOUR-IMAGE-SAVE-PATH-HERE'
    - With the path where you want to save the image

### Run the file
```
powershell ./Main.ps1
```

## Note!
There are no guarantees that the script will work perfectly, if for example the image of the day is a video, which can't be set as a wallpaper the script will set your background to a solid color.

Run this at your own risk.
