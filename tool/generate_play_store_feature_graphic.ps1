Add-Type -AssemblyName System.Drawing

$projectRoot = Split-Path -Parent $PSScriptRoot
$sourcePath = Join-Path $projectRoot 'media\play-store\qr-toleg-ai-generated-feature-graphic-artwork.png'
$outputPath = Join-Path $projectRoot 'media\play-store\qr-toleg-feature-graphic.png'

$width = 1024
$height = 500
$canvas = [System.Drawing.Bitmap]::new(
    $width,
    $height,
    [System.Drawing.Imaging.PixelFormat]::Format24bppRgb
)
$graphics = [System.Drawing.Graphics]::FromImage($canvas)
$source = [System.Drawing.Image]::FromFile($sourcePath)

try {
    $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $sourceRatio = $source.Width / $source.Height
    $targetRatio = $width / $height
    if ($sourceRatio -lt $targetRatio) {
        $cropHeight = [int]($source.Width / $targetRatio)
        $sourceRect = [System.Drawing.Rectangle]::new(
            0,
            [int](($source.Height - $cropHeight) / 2),
            $source.Width,
            $cropHeight
        )
    }
    else {
        $cropWidth = [int]($source.Height * $targetRatio)
        $sourceRect = [System.Drawing.Rectangle]::new(
            [int](($source.Width - $cropWidth) / 2),
            0,
            $cropWidth,
            $source.Height
        )
    }

    $destinationRect = [System.Drawing.Rectangle]::new(0, 0, $width, $height)
    $graphics.DrawImage(
        $source,
        $destinationRect,
        $sourceRect,
        [System.Drawing.GraphicsUnit]::Pixel
    )

    $titleFont = [System.Drawing.Font]::new(
        'Segoe UI',
        72,
        [System.Drawing.FontStyle]::Bold,
        [System.Drawing.GraphicsUnit]::Pixel
    )
    $taglineFont = [System.Drawing.Font]::new(
        'Segoe UI',
        34,
        [System.Drawing.FontStyle]::Regular,
        [System.Drawing.GraphicsUnit]::Pixel
    )
    $whiteBrush = [System.Drawing.SolidBrush]::new(
        [System.Drawing.Color]::FromArgb(255, 250, 251, 247)
    )
    $mintBrush = [System.Drawing.SolidBrush]::new(
        [System.Drawing.Color]::FromArgb(255, 166, 237, 194)
    )

    try {
        $oUmlaut = [char]0x00F6
        $cCedilla = [char]0x00E7
        $nCaron = [char]0x0148
        $title = "QR T${oUmlaut}leg"
        $tagline = "Balans ge${cCedilla}irmegi${nCaron}`na${nCaron}sat usuly"

        $graphics.FillRectangle($mintBrush, 112, 151, 64, 7)
        $graphics.DrawString($title, $titleFont, $whiteBrush, 105, 174)
        $graphics.DrawString(
            $tagline,
            $taglineFont,
            $whiteBrush,
            109,
            271
        )
    }
    finally {
        $mintBrush.Dispose()
        $whiteBrush.Dispose()
        $taglineFont.Dispose()
        $titleFont.Dispose()
    }

    $canvas.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)

    if ($canvas.Width -ne $width -or $canvas.Height -ne $height) {
        throw "Generated feature graphic has unexpected dimensions: $($canvas.Width)x$($canvas.Height)"
    }
}
finally {
    $source.Dispose()
    $graphics.Dispose()
    $canvas.Dispose()
}
