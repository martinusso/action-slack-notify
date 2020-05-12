# action-slack-notify

**Based on https://github.com/rtCamp/action-slack-notify**

## Usage

You can use this action after any other action. Here is an example setup of this action:

```
    Create a .github/workflows/slack-notify.yml file in your GitHub repo.
    Add the following code to the slack-notify.yml file.
```

```
on: push
name: Slack Notification Demo
jobs:
  slackNotification:
    name: Slack Notification
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Slack Notification
      uses: martinusso/action-slack-notify@v1.2.0
      env:
        SLACK_WEBHOOK: ${{ secrets.SLACK_WEBHOOK }}
```

Create SLACK_WEBHOOK secret using GitHub Action's Secret. You can generate a Slack incoming webhook token from here.

## Environment Variables

By default, action is designed to run with minimal configuration but you can alter Slack notification using following environment variables:

Variable          | Default                                               | Purpose
------------------|-------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------
SLACK_CHANNEL     | Set during Slack webhook creation                     | Specify Slack channel in which message needs to be sent
SLACK_USERNAME    | `rtBot`                                               | The name of the sender of the message. Does not need to be a "real" username
SLACK_ICON        | ![rtBot Avatar](https://github.com/rtBot.png?size=32) | User/Bot icon shown with Slack message. It uses the URL supplied to this env variable to display the icon in slack message.
SLACK_ICON_EMOJI  | -                                                     | User/Bot icon shown with Slack message, in case you do not wish to add a URL for slack icon as above, you can set slack emoji in this env variable. Example value: `:bell:` or any other valid slack emoji.
SLACK_COLOR       | `good` (green)                                        | You can pass an RGB value like `#efefef` which would change color on left side vertical line of Slack message.
SLACK_MESSAGE     | Generated from git commit message.                    | The main Slack message in attachment. It is advised not to override this.
SLACK_TITLE       | Message                                               | Title to use before main Slack message.

You can see the action block with all variables as below:

```yml
    - name: Slack Notification
      uses: martinusso/action-slack-notify@v1.2.0
      env:
        SLACK_CHANNEL: general
        SLACK_COLOR: '#3278BD'
        SLACK_ICON: https://github.com/rtCamp.png?size=48
        SLACK_MESSAGE: 'Post Content :rocket:'
        SLACK_TITLE: Post Title
        SLACK_USERNAME: rtCamp
        SLACK_WEBHOOK: ${{ secrets.SLACK_WEBHOOK }}
```
