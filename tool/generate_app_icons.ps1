Add-Type -AssemblyName System.Drawing

$projectRoot = Split-Path -Parent $PSScriptRoot
$green = [System.Drawing.Color]::FromArgb(255, 22, 121, 74)
$white = [System.Drawing.Color]::FromArgb(255, 250, 251, 247)
$mint = [System.Drawing.Color]::FromArgb(255, 166, 237, 194)

function New-AppIcon {
    param(
        [Parameter(Mandatory = $true)]
        [int]$Size,
        [Parameter(Mandatory = $true)]
        [string]$OutputPath
    )

    $bitmap = [System.Drawing.Bitmap]::new($Size, $Size)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::None
    $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::Half
    $graphics.Clear($green)

    $module = [Math]::Round($Size * 0.145)
    $gap = [Math]::Max(1, [Math]::Round($Size * 0.035))
    $markSize = (3 * $module) + (2 * $gap)
    $originX = [Math]::Round(($Size - $markSize) / 2)
    $originY = [Math]::Round(($Size - $markSize) / 2)

    $whiteBrush = [System.Drawing.SolidBrush]::new($white)
    $mintBrush = [System.Drawing.SolidBrush]::new($mint)
    try {
        $graphics.FillRectangle($whiteBrush, $originX, $originY, $module, $module)
        $graphics.FillRectangle(
            $whiteBrush,
            $originX + $module + $gap,
            $originY,
            $module,
            $module
        )
        $graphics.FillRectangle(
            $mintBrush,
            $originX + (2 * ($module + $gap)),
            $originY,
            $module,
            $module
        )
        $graphics.FillRectangle(
            $whiteBrush,
            $originX + $module + $gap,
            $originY + $module + $gap,
            $module,
            $module
        )
        $graphics.FillRectangle(
            $whiteBrush,
            $originX + $module + $gap,
            $originY + (2 * ($module + $gap)),
            $module,
            $module
        )

        $directory = Split-Path -Parent $OutputPath
        if (-not (Test-Path $directory)) {
            New-Item -ItemType Directory -Force $directory | Out-Null
        }
        $bitmap.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
        $mintBrush.Dispose()
        $whiteBrush.Dispose()
        $graphics.Dispose()
        $bitmap.Dispose()
    }
}

$androidIcons = @{
    'mipmap-mdpi\ic_launcher.png' = 48
    'mipmap-hdpi\ic_launcher.png' = 72
    'mipmap-xhdpi\ic_launcher.png' = 96
    'mipmap-xxhdpi\ic_launcher.png' = 144
    'mipmap-xxxhdpi\ic_launcher.png' = 192
}

foreach ($entry in $androidIcons.GetEnumerator()) {
    New-AppIcon `
        -Size $entry.Value `
        -OutputPath (Join-Path $projectRoot "android\app\src\main\res\$($entry.Key)")
}

$iosIcons = @{
    'Icon-App-20x20@1x.png' = 20
    'Icon-App-20x20@2x.png' = 40
    'Icon-App-20x20@3x.png' = 60
    'Icon-App-29x29@1x.png' = 29
    'Icon-App-29x29@2x.png' = 58
    'Icon-App-29x29@3x.png' = 87
    'Icon-App-40x40@1x.png' = 40
    'Icon-App-40x40@2x.png' = 80
    'Icon-App-40x40@3x.png' = 120
    'Icon-App-60x60@2x.png' = 120
    'Icon-App-60x60@3x.png' = 180
    'Icon-App-76x76@1x.png' = 76
    'Icon-App-76x76@2x.png' = 152
    'Icon-App-83.5x83.5@2x.png' = 167
    'Icon-App-1024x1024@1x.png' = 1024
}

$iosDirectory = Join-Path $projectRoot 'ios\Runner\Assets.xcassets\AppIcon.appiconset'
foreach ($entry in $iosIcons.GetEnumerator()) {
    New-AppIcon `
        -Size $entry.Value `
        -OutputPath (Join-Path $iosDirectory $entry.Key)
}

New-AppIcon `
    -Size 1024 `
    -OutputPath (Join-Path $projectRoot 'media\icon-concepts\qr-toleg-icon-final.png')

New-AppIcon `
    -Size 512 `
    -OutputPath (Join-Path $projectRoot 'media\play-store\qr-toleg-play-store-icon.png')
