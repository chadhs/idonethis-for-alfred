# I Done This for Alfred
## instructions here: https://github.com/chadhs/idonethis-for-alfred
## need help? drop me a line.
## hello@chadstovern.com or @chadhs


## enter your api token between the double quotes below
api_token=""


## enter your team_id between the double quotes below
team_id=""


###################################
### DO NOT EDIT BELOW THIS LINE ###
######### HERE BE DRAGONS #########
###################################

## static values
api_version="v2"
done_date=$(date '+%Y-%m-%d')
base_uri="https://beta.idonethis.com/api/${api_version}"
done="{query}"
### let's replace single quotes, double quotes, and backticks with unicode values so we can include them easily in the done
done="${done//\'/\\u0027}"
done="${done//\"/\\u0022}"
done="${done//\`/\\u0060}"


## add done
### submit done to api saving the return response
post_result=$(curl -sS -X "POST" "${base_uri}/entries" \
    -H "Authorization: Token ${api_token}" \
    -H "Content-Type: application/json; charset=utf-8" \
    -d "{\"body\":\"${done}\",\"team_id\":\"${team_id}\",\"occurred_on\":\"${done_date}\"}")
post_success=$(echo ${post_result} | grep created_at)

## if it was successful print out success message
## if the request failed, print it, along with an error message
if [[ -n $post_success ]]
then
    echo \"{query}\" has been posted.
else
    echo $post_result
    echo RUH ROH! \"{query}\" did not post.
fi
