---
date: 2025-04-25
tags:
- python
- pytest
- test
slug: python-tests-isolated-mock
title: Achieving Isolated Mocks in Python Tests
categories:
lastMod: 2025-04-28
---
Python's [unittest.mock](https://docs.python.org/3/library/unittest.mock.html) library provides powerful and flexible mocking capabilities, simplifying test setups compared to many other programming languages. However, ensuring that mocks remain isolated and do not inadvertently affect other parts of your tests is crucial for maintaining reliable test suites.

## Example Scenario

Consider the following logging setup:

```python
import logging
import sys
from google.cloud.logging_v2.handlers.structured_log import StructuredLogHandler
import settings

def setup_logging() -> None:
  logger = logging.getLogger()

  # Clear existing handlers to prevent duplicate logs
  logger.handlers = []
  logger.setLevel(settings.LOG_LEVEL)
  handler_out = StructuredLogHandler(stream=sys.stdout)
  
  logger.addHandler(handler_out)
  
  # Manually configure handlers for loggers not inheriting from root
  logger_gunicorn = logging.getLogger("gunicorn.error")
  logger_gunicorn.handlers = []
  logger_gunicorn.addHandler(handler_out)
```

We want to test whether both logger and logger_gunicorn have the handler correctly added.

## Isolating Mocks in Pytest

To ensure each logger is mocked separately based on the logger's name, use a defaultdict to manage multiple mock instances. Here's how you can structure the test clearly with pytest:

```python
import logging

from collections import defaultdict
from unittest.mock import MagicMock

from your_module import setup_logging

def test_setup_logging(mocker):
  # Dictionary that creates a new MagicMock for each unique logger name
  loggers: dict[str, MagicMock] = defaultdict(
      lambda: mocker.MagicMock(spec=logging.Logger)
  )

  # Patch logging.getLogger to return a mock specific to the logger's name
  mock_get_logger = mocker.patch(
      "logging.getLogger", side_effect=lambda name=None: loggers[name]
  )

  setup_logging()

  # Assert that each logger had 'addHandler' called exactly once
  assert mock_get_logger().addHandler.call_count == 1
  assert mock_get_logger("gunicorn.error").addHandler.call_count == 1
```

## Explanation

`defaultdict` ensures each logger name generates an isolated `MagicMock` object.

The patched `getLogger` returns a mock based on the provided logger name.



Explicit assertions confirm the expected handler addition behavior.

This approach guarantees test isolation and accuracy, making your testing suite robust and maintainable.
