#!/bin/bash

podman exec \
  setup-app \
  python3 /opt/app/main.py
