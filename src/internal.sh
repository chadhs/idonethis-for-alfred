# iDoneThis for Alfred
## instructions here: https://github.com/chadhs/idonethis-for-alfred
## need help? drop me a line.
## chadhs@digitalnomad.im or @chadhs


## enter your api token between the quotes below
### (see the instructions link above for how to get your token)

api_token=""


## enter your team_short_name here
### (most likely your username if you're not on a team)
### (for teams use your team_short_name, see the instructions link above)

team_short_name=""


###################################
### DO NOT EDIT BELOW THIS LINE ###
######### HERE BE DRAGONS #########
###################################


oIFS=$IFS
IFS="
"


## static values
done_date=`date '+%Y-%m-%d'`
base_uri="https://idonethis.com/api/v0.1"
tmp_file="/tmp/done.json"
done="{query}"
### let's replace single and double quotes with unicode values so we can include them easily in the done
done="${done//\'/\\u0027}"
done="${done//\"/\\u0022}"


## add done
### create json temp file
cat > $tmp_file << DONE
{"team": "${base_uri}/teams/${team_short_name}/", "raw_text": "${done}", "done_date": "${done_date}"}
DONE
### submit done to api
curl -H "Content-type:application/json" -H "Authorization: Token ${api_token}" --data @${tmp_file} ${base_uri}/dones/


## a bit of cleanup
IFS=$oIFS
rm $tmp_file
