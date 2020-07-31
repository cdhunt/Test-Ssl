class TestSsl {
    [string] $Image = 'drwetter/testssl.sh'
    [string] $Uri
    hidden [string] $Tag = '3.0'
    [string[]] $TestSslOptions
    [string[]] $DockerOptions

    testssl ([string]$uri) {
        $this.Uri = $uri
        $this.DockerOptions += 'docker run --rm -ti'
    }

    [string] TestSslOptionsToString()
    {
        return $this.TestSslOptions -join ' '
    }

    [string] DockerOptionsToString()
    {
        return $this.DockerOptions -join ' '
    }

    [TestSsl] ServerDefaults()
    {
        $this.TestSslOptions += '--server-defaults'
        return $this
    }

    [TestSsl] Fast()
    {
        $this.TestSslOptions += '--fast'
        return $this
    }

    [TestSsl] Quiet()
    {
        $this.TestSslOptions += '--quiet'
        return $this
    }

    [TestSsl] Json()
    {
        $this.TestSslOptions += '--jsonfile "out/"'
        $this.DockerOptions += '-v "$($pwd.path):/home/testssl/out"'
        return $this
    }

    [TestSsl] Html()
    {
        $this.TestSslOptions += '--htmlfile "out/"'
        $this.DockerOptions += '-v "$($pwd.path):/home/testssl/out"'
        return $this
    }

    [TestSsl] Severity([string]$sev)
    {
        if ($sev -notin @('Low','Medium','High','Critical'))
        {
            throw "Valid Severity options are 'Low','Medium','High', or 'Critical'."
        }
        $this.TestSslOptions += "--severity $sev"
        return $this
    }

    [string] ToString()
    {
        return '{0} {1}:{2} {3} {4}' -f $this.DockerOptionsToString(), $this.Image, $this.Tag, $this.TestSslOptionsToString(), $this.Uri
    }
}