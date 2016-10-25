# pushcert-automater

This tool can be used for quick and easy generation of push certificates for large volumes of apps.

## Pre-Requisites
### jq

Make sure you have the CLI JSON parsing tool installed using brew (If you don't have homebrew installed, visit [this](https://stedolan.github.io/jq/download/) page).
`brew install jq`

### fastlane

Make sure you have fastlane installed using the following command:

`sudo gem install fastlane --verbose`

## Usage

- Set up your JSON file using the provided [example](./example.json)
- Run `./regenerate.sh`
