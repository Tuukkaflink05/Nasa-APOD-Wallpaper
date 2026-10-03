# Nasa-APOD-Wallpaper

### Fetch the Nasa Astronomy Picture of the Day and set it as Windows wallpaper

- uses powershell commands to fetch, save, and set the Nasa astronomy picture of the day as your wallpaper.

- [Current picture of the day](https://apod.nasa.gov/apod/)

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

### rename the config.ps1.template file

```
ren config.ps1.template config.ps1
```

### Open the config.ps1 file and change placeholder values:
#### required
- 'YOUR-API-KEY-HERE'
    - with your nasa api key

- 'YOUR-IMAGE-SAVE-PATH-HERE'
    - With the path to a directory where you want to save the images

#### optional

- 'YOUR-ALT-SAVE-PATH-HERE'
    - if you want to save the alt text of the image
    - With the path you want to save the alt text of the image
    - ``.txt`` file

- 'YOUR-EXPLANATION-SAVE-PATH-HERE'
    - if you want to save the html explanation of the image
    - With the path you want to save the explanation text of the image
    - ``.html`` file




### Run the file
```
powershell ./Main.ps1
```

## Note!
might not work all the time!

Run this at your own risk.
