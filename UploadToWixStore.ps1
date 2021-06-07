# Create a web application session so that we can interact w/ a wix.com web application.

$Credential = Get-Credential

## Get initial Cookies

$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "User-Agent:Mozilla/4.0 (compatible; MSIE 7.0)")

$result - $wc.DownloadString("https://www.wix.com/")
$cookie = $wc.ResponseHeaders["Set-Cookie"]
$cookie = ($cookie.Split(',') -match '^\S+=\S+;' -replace ';.*',") -join '; '

$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "User-Agent: Mozilla/4.0 (compatible, MSIE 7.0)")
$wc.Headers.Add("Cookie", $cookie)
$postValues = New-Object System.Collections.Specialized.NameValueCollection
$postValues.Add("email", $credential.GetNetworkCredential().Username)
$postValues.Add("pass", $credential.GetNetworkCredential().Password)

# Get resulting cookie and convert it into the form to be returned in query string

$result = $wc.UploadValues("", $postValues)
$cookie = $wc.ResponseHeaders["Set-Cookie"]
$cookie = ($cookie.Split(',') -match '^\S+=\S+;' -replace ';.*',") -join ';'

# Now we can use the cookie. 
$cookie
