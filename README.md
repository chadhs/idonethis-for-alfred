# I Done This For Alfred

## Summary

This workflow uses the I Done This API to quickly send updates to your [idonethis.com](http://idonethis.com) account.

**Carefully** choose which version you install to match the version of I Done This and Alfred you are using.  It's safe to consider I Done This version 1 and Alfred 2 deprecated.  Please consider upgrading to Alfred 3 and your I Done This account to version 2 soon.

## Installation

- Click to [`Download ZIP`](https://github.com/chadhs/idonethis-for-alfred/archive/master.zip) or on the green "Clone or download" button above on the right.
- Unpack the ZIP file

### I Done This 2.0 and Alfred 3

- In the unpacked folder navigate to `workflows/idonethis-v2`
- Double–click the `idonethis2-for-alfred3.alfredworkflow` file to install it
- In the workflows section of Alfred select the `I Done This` workflow
- Click the `[x]` icon in the top-right of the workflow to edit it.
- Enter your `api_token`
    Follow these instructions to obtain your API token: http://help.idonethis.com/article/139-obtaining-your-api-token **Keep it secret, keep it safe.**
- Enter your `team_id`
    - To get your `team_id`:
        1. Login to https://beta.idonethis.com
        2. Click on either the personal or team log you want to send your `dones`, `goals`, and `blockers` to.
        3. Grab the value after `t` in the url: `/t/<team_id>/`.

### I Done This 1.0 and Alfred 2 or 3

- In the unpacked folder navigate to `workflows/idonethis-v1`
- Double–click the `idonethis-for-alfred.alfredworkflow` file to install it
- In the workflows section of Alfred select the `I Done This` workflow
- Double-click both `bash scripts` in the `workflow` to edit them; repeat the next two steps for each script.
- Enter your `api\token` - Go here: https://idonethis.com/api/token/, to get your token. **Keep it secret, keep it safe.**
- Enter your `team\short-name` - Go here: https://idonethis.com/home/, then click on either the personal or team link you want to send your `dones` and `goals` to. Grab the value after `cal` in the url: `/cal/<team short name>/`.

## How to use

### I Done This 2.0 and Alfred 3

- Type `idt` followed by your update and press `Enter`; you're done!
- Just like responding via email you can enter goals by starting your update with a `[]` and blockers by starting your update with a `!`.

- Type `idtlist` to see your incomplete goals
- Choose the goal you want to mark as done

### I Done This 1.0 and Alfred 2 or 3

- Type `idid` followed by your **done** and press `Enter`; you're done!
- Type `iwill` followed by your **goal** and press `Enter`; you're done!

## Contact

- Workflow and version 1 icon by: Chad Stovern (version 2 icon is the official I Done This logo used with permission)
- twitter: [@chadhs](https://twitter.com/chadhs)
- mail: <help@chadstovern.com>
- blog: <http://www.chadstovern.com>

If you need help please drop me a line via email or on twitter. Watch this page for updates. :-)

## Contributors

Be sure to thank the fine folks who've contributed improvements to I Done This for Alfred!

- [chadhs](https://github.com/chadhs)
- [jeffbyrnes](https://github.com/jeffbyrnes)
- [laythun](https://github.com/laythun)
- [ladislas](https://github.com/ladislas)

