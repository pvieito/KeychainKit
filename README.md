## Helping Guide


#### Entitlements
Generic wildcard entitlements aren't allowed anymore. Specify the exact entitlement(s) in the file, up to 36.

##### Codesigning Identity
Set the identity with `export CODESIGNKIT_DEFAULT_IDENTITY=<ID>`. You can list availible IDs with `security find-identity -pcodesigning`.

##### Show Key Value
Values only show with `--verbose` option.
