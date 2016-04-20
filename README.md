# E2E Tests
This project in based on Behave/Python + Toolium + Selenium WebDriver

## Getting Started

```
$ pip install -r requirements.txt
```

### Configure your local properties
Rename `conf/local-properties.cfg.template` to `conf/local-properties.cfg`
and configure with your local properties (navigator, server, ....)

Example of your local config:
```text
[Browser]
browser: chrome
chromedriver_path: /bin/chromedriver

[VisualTests]
enabled: true

[Server]
enabled: false

[Jira]
enabled: false
```

__Optional__
Before install, you can use a virtual environment with the required packages:

NOTE: You may need to set GIT_SSL_NO_VERIFY=true environment variable in your machine

```
make venv
```

or

```
virtualenv ENV
source ENV/bin/activate
```


## Execution
`tests/web` subdirectory contains different tests.

Run tests:
```
$ behave tests/web
```