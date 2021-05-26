#!/bin/bash
git pull origin main
make docker-pull
make production
