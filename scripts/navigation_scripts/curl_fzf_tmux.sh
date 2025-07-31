#!/bin/bash

function view_yaml() {
  yq '.curl[].data.name = "Kabil"' 'test_file.yaml'
  yq '.curl[0]' 'test_file.yaml'
}

view_yaml
