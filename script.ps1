# Copyright (c) 2015-2017 VMware, Inc.  All rights reserved.
# Script for VMware vRealize Automation and Software Services

param(
[string]$PROPERTIES = $properties,
[string]$CUSTOMPROPERTIES = $customproperties,
[string]$FILEPATH = $filepath
)

$NEWLINE = "`n"
$CONTENT = ""

$ESCAPEDPROPERTIES = $PROPERTIES.replace('%',':')
$PROPERTYLIST = $ESCAPEDPROPERTIES.split(',')

foreach($PROPERTY in $PROPERTYLIST) {
   if ($PROPERTY.StartsWith("__"))
   {
        $PROPERTYSUFFIX = $PROPERTY.Substring(2)
        $CONTENT = "$CONTENT$PROPERTYSUFFIX$NEWLINE"
   } else {
        $CONTENT = "$CONTENT$PROPERTY$NEWLINE"
   }
}

If (Test-Path  $FILEPATH\appd.properties)
{
    #Deleting the file if aleady exists
    Remove-Item -Force $FILEPATH\appd.properties
}

Add-Content $FILEPATH\appd.properties $CONTENT


$CONTENT = ""
$ESCAPEDCUSTOMPROPERTIES = $CUSTOMPROPERTIES.replace('%',':')
$CUSTOMPROPERTYLIST = $ESCAPEDCUSTOMPROPERTIES.split(',')

foreach($PROPERTY in $CUSTOMPROPERTYLIST) {
   $CONTENT = "$CONTENT$PROPERTY$NEWLINE"
}

If (Test-Path  $FILEPATH\custom.properties)
{
    #Deleting the file if aleady exists
    Remove-Item -Force $FILEPATH\custom.properties
}

Add-Content $FILEPATH\custom.properties $CONTENT

