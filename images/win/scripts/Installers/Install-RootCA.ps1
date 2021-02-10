# https://www.sysadmins.lv/blog-en/how-to-retrieve-certificate-purposes-property-with-cryptoapi-and-powershell.aspx
# https://www.sysadmins.lv/blog-en/dump-authroot-and-disallowed-certificates-with-powershell.aspx
# https://www.sysadmins.lv/blog-en/constraining-extended-key-usages-in-microsoft-windows.aspx

function Add-ExtendedCertType {
    $signature = @"
        [DllImport("Crypt32.dll", SetLastError = true, CharSet = CharSet.Auto)]
        public static extern bool CertGetCertificateContextProperty(
            IntPtr pCertContext,
            uint dwPropId,
            Byte[] pvData,
            ref uint pcbData
        );

        [DllImport("Crypt32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern bool CertSetCertificateContextProperty(
            IntPtr pCertContext,
            int dwPropId,
            uint dwFlags,
            IntPtr pvData
        );
"@

    Add-Type -MemberDefinition $signature -Namespace PKI -Name Cert
}

function Get-CertificatesWithoutPropId {
    # List installed certificates
    $certs = Get-ChildItem -Path Cert:\LocalMachine\Root

    Write-Host "Certificates without CERT_NOT_BEFORE_FILETIME_PROP_ID property"
    $certsWithoutPropId = @{}
    $certs | ForEach-Object -Process {
        $certHandle = $_.Handle
        $isPropertySet = [PKI.Cert]::CertGetCertificateContextProperty(
            $certHandle, $CERT_NOT_BEFORE_FILETIME_PROP_ID, $null, [ref]$null
        )
        if (-not $isPropertySet) {
            Write-Host "Subject: $($_.Subject)"
            $certsWithoutPropId[$_.Thumbprint] = $null
        }
    }
    $certsWithoutPropId
}
function Import-SSTFromWU {
    # Serialized Certificate Store File
    $sstFile = "$env:TEMP\roots.sst"
    # Generate SST from Windows Update
    $result = certutil.exe -generateSSTFromWU $sstFile
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[Error]: failed to generate $sstFile sst file`n$result"
        exit $LASTEXITCODE
    }

    $result = certutil.exe -dump $sstFile
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[Error]: failed to dump $sstFile sst file`n$result"
        exit $LASTEXITCODE
    }

    try {
        Import-Certificate -FilePath $sstFile -CertStoreLocation Cert:\LocalMachine\Root
    } catch {
        Write-Host "[Error]: failed to import ROOT CA`n$_"
        exit 1
    }
}

function Clear-CertificatesPropId {
    param([hashtable]$CertsWithoutPropId)

    # List installed certificates
    $certs = Get-ChildItem -Path Cert:\LocalMachine\Root

    # Clear property CERT_NOT_BEFORE_FILETIME_PROP_ID
    $certs | ForEach-Object -Process {
        $thumbprint = $_.Thumbprint
        if ($certsWithoutPropId.ContainsKey($thumbprint)) {
            $subject = $_.Subject
            $certHandle = $_.Handle
            $result = [PKI.Cert]::CertSetCertificateContextProperty(
                $certHandle, $CERT_NOT_BEFORE_FILETIME_PROP_ID, 0, [System.IntPtr]::Zero
            )
            if ($result) {
                Write-Host "[Success] Clear CERT_NOT_BEFORE_FILETIME_PROP_ID property $subject"
            } else {
                Write-Host "[Fail] Clear CERT_NOT_BEFORE_FILETIME_PROP_ID property $subject"
            }
        }
    }
}

function Disable-RootAutoUpdate {
    Write-Host "Disable auto root update mechanism"
    $regPath = "HKLM:\Software\Policies\Microsoft\SystemCertificates\AuthRoot"
    $regKey = "DisableRootAutoUpdate"

    # Create the registry key if it doesn't exist
    if (-not (Test-Path $regPath)) {
        Write-Verbose "Creating $regPath"
        New-Item $regPath | Out-Null
    }

    Set-ItemProperty $regPath -Name $regKey -Type DWord -Value 1
}

# Property to remove
$CERT_NOT_BEFORE_FILETIME_PROP_ID = 126

# Add extended cert type
Add-ExtendedCertType

# Get certificates without property CERT_NOT_BEFORE_FILETIME_PROP_ID
$certsWithoutPropId = Get-CertificatesWithoutPropId

# Download and install the latest version of root ca list
Import-SSTFromWU

# Clear property CERT_NOT_BEFORE_FILETIME_PROP_ID
if ($certsWithoutPropId.Count -gt 0) {
    Clear-CertificatesPropId -CertsWithoutPropId $certsWithoutPropId
} else {
    Write-Host "Nothing to clear"
}

# Disable auto root update mechanism
Disable-RootAutoUpdate
