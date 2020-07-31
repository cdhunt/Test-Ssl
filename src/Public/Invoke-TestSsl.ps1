function Invoke-TestSsl {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position=0)]
        [string]
        $Uri,

        [Parameter()]
        [switch]
        $ServerDefaults,

        [Parameter()]
        [switch]
        $Fast,

        [Parameter()]
        [switch]
        $Quiet,

        [Parameter()]
        [switch]
        $JsonFile,

        [Parameter()]
        [switch]
        $HtmlFile,

        [Parameter(Position=1)]
        [ValidateSet('3.0','3.1dev','latest')]
        [string]
        $Tag,

        [Parameter(Position=2)]
        [string]
        $Image
    )


    $test = [TestSsl]::new($Uri)

    if ($ServerDefaults) {
        $test = $test.ServerDefaults()
    }
    if ($Fast) {
        $test = $test.Fast()
    }
    if ($Quiet) {
        $test = $test.Quiet()
    }
    if ($JsonFile) {
        $test = $test.Json()
    }
    if ($HtmlFile) {
        $test = $test.Html()
    }
    if ($PSBoundParameters.ContainsKey('Tag')) {
        $test.Tag = $Tag
    }
    if ($PSBoundParameters.ContainsKey('Image')) {
        $test.Image = $Image
    }

    Invoke-Expression $test.ToString()
}