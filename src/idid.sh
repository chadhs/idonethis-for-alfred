# iDoneThis for Alfred
## instructions here: https://github.com/chadhs/idonethis-for-alfred
## need help? drop me a line.
## hello@chadstovern.com or @chadhs


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
api_version="v0.1"
done_date=`date '+%Y-%m-%d'`
base_uri="https://idonethis.com/api/${api_version}"
tmp_file="/tmp/done.json"
done="{query}"
### let's replace single and double quotes with unicode values so we can include them easily in the done
done="${done//\'/\\u0027}"
done="${done//\"/\\u0022}"
done="${done//\`/\\u0060}"


## add done
### create json temp file
cat > $tmp_file << DONE
{"team": "${base_uri}/teams/${team_short_name}/", "raw_text": "${done}", "done_date": "${done_date}"}
DONE
### submit done to api saving the return response
post_result=$(curl -s -H "Content-type:application/json" -H "Authorization: Token ${api_token}" --data @${tmp_file} ${base_uri}/dones/)
post_success=`echo ${post_result} | grep created`

## if it was successful print out success message
## if the request failed, print it, along with an error message
if [[ -n $post_success ]]
then
    echo ${done} has been posted.
else
    echo $post_result
    echo RUH ROH! ${done} did not post.
fi

## a bit of cleanup
IFS=$oIFS
rm $tmp_file
