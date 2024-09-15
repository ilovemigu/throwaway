set -e # exit script on error
version=expressvpn_3.76.0.4-1_amd64.deb
curl https://www.expressvpn.works/clients/linux/$version -o /home/$USER/Downloads/$version

baseDir=$(readlink -f $(dirname $0)) # pwd of shell script

mv  $(find /home/$USER/Downloads -maxdepth 1 -type f  -name "expre*.deb" ) $baseDir/$version
curVPN=$(basename $(find $baseDir -maxdepth 1 -type f  -name "expre*.deb" ))

# filenames
preProcessCountries="preProcessCountries"
pyname="pythonCountry.py"
activateCode="activateCode"
postProcessCountries="postProcessCountries"
debPkg="$baseDir/$curVPN"

sudo dpkg -i $baseDir/$curVPN
expressvpn activate # just take user input

expressvpn list > "$baseDir/$preProcessCountries"
python3 $baseDir/$pyname

declare -a countries # indexed array
i=0
while IFS= read -r file; do
        countries+=($file)
        ((i=i+1))

done < "$baseDir/$postProcessCountries"
echo ${countries[($RANDOM % $i)]}
expressvpn connect ${countries[($RANDOM % $i)]}
expressvpn preferences set block_all true # blocks adult content too
expressvpn preferences set send_diagnostics false