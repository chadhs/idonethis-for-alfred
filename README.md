# I Done This For Alfred

## Summary

This workflow uses the iDoneThis API to quickly send updates to your [iDoneThis.com](http://idonethis.com) account.

**Carefully** choose which version you install to match the version of idonethis and alfred you are using.  It's safe to consider idonethisv1 and alfred2 deprecated.  Please consider upgrading to alfred3 and your idonethis account to v2.x soon.

## Installation

- Click the [`Download ZIP`](https://github.com/chadhs/idonethis-for-alfred/archive/master.zip) button on the right side of this page
- Unpack the ZIP file

### I Done This 2.0 and Alfred 3

- In the unpacked folder navigate to `workflows/idonethis-v2`
- Double–click the `idonethis2-for-alfred3.alfredworkflow` file to install it
- In the workflows section of Alfred select the `I Done This` workflow
- Double-click the `bash scripts` in the `workflow` to edit it.
- Enter your `api_token` - Contact support@idonethis.com to get your token, url to grab it yourself coming very soon. **Keep it secret, keep it safe.**
- Enter your `team_id` - To get your `team_id` Login to https://beta.idonethis.com, then click on either the personal or team log you want to send your `dones`, `goals`, and `blockers` to. Grab the value after `t` in the url: `/t/<team_id>/`.

### iDoneThis 1.0 and Alfred 2 or 3

- In the unpacked folder navigate to `workflows/idonethis-v1`
- Double–click the `idonethis-for-alfred.alfredworkflow` file to install it
- In the workflows section of Alfred select the `iDoneThis` workflow
- Double-click both `bash scripts` in the `workflow` to edit them; repeat the next two steps for each script.
- Enter your `api\token` - Go here: https://idonethis.com/api/token/, to get your token. **Keep it secret, keep it safe.**
- Enter your `team\short-name` - Go here: https://idonethis.com/home/, then click on either the personal or team link you want to send your `dones` and `goals` to. Grab the value after `cal` in the url: `/cal/<team short name>/`.

## How to use

### I Done This 2.0 and Alfred 3

- Type `idt` followed by your update and press `Enter`; you're done!
- Just like responding via email you can enter goals by starting your update with a `[]` and blockers by starting your update with a `!`.

### iDoneThis 1.0 and Alfred 2 or 3

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
- [laythun](https://github.com/laythun)
- [ladislas](https://github.com/ladislas)

