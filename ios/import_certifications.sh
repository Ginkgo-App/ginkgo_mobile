#!/bin/sh

# Decrypt the files
# --batch to prevent interactive command --yes to assume "yes" for questions
gpg --quiet --batch --yes --decrypt --passphrase="$GPG_PASSWORD" --output ios/keys/Certificates.p12 ios/keys/Certificates.p12.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$GPG_PASSWORD" --output ios/keys/Test_Github_Actions_Adhoc.mobileprovision ios/keys/Test_Github_Actions_Adhoc.mobileprovision.gpg

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

echo "List profiles"
ls ~/Library/MobileDevice/Provisioning\ Profiles/
echo "Move profiles"
cp ios/keys/*.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/
echo "List profiles"
ls ~/Library/MobileDevice/Provisioning\ Profiles/

echo "Import certifications"
security create-keychain -p "" build.keychain
security import ios/keys/Certificates.p12 -t agg -k ~/Library/Keychains/build.keychain -P "$CERTIFICATES_PASSWORD" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain
security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain