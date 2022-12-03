import { message, danger } from "danger"

const app = danger.git.fileMatch("MobileDesignSampleApp/**.swift")
const classes = danger.git.fileMatch("Sources/**.swift")
const tests = danger.git.fileMatch("Tests/**.swift")


const pr = danger.github.pr
const title = pr.title
const description = pr.body

const prTitlePattern = /^(feature|Bugfix|Refactor|Hotfix|Feature|bugfix|refactor|hotfix|release)\/*/g
if (!prTitlePattern.test(title)) {
fail("PR title: " + title + "incorrect. should be <feature|bugfix|refactor|hotfix|release>/<_name> ")
}


const prDescriptionPattern = /https:\/\/app.clickup.com\/t\/\*/g
if (!prDescriptionPattern.test(description)) {
fail(`🔍 I can't find the Clickup ticket URL in the PR body, please add a link to the Jira ticket, it 's the most efficient way to jump to the corresponding ticket in Clickup🚀`)
}

const hasChangelog = danger.git.modified_files.includes("CHANGELOG.md")

if (hasChangelog) {
message("Thanks - We :heart: our [documentarians](https://keepachangelog.com/en/1.0.0/)!")
} else {
warn("You have to update CHANGELOG.md")
}

if ((app.modified && classes.modified) && (!tests.modified)) {
warn("You have app changes without tests.")
}
