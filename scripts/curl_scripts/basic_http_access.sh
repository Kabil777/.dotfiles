#!/bin/bash

function get {
  curl -X GET "$1"
}
#
# post() {
#
# }
#
# put() {
#
# }
#
# delete() {

# }

case "$1" in
get)
  get "$2"
  ;;
post)
  post "$2" "$3"
  ;;
*)
  echo "Usage: $0 {get|post|put|delete} <url> [data]"
  exit 1
  ;;
esac
