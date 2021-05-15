# Find and set branch name var if in git repository.
git_branch_name() {
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]]; then
    :
  else
    echo ' ('$branch')'
  fi
}

function kubectl_profile() {
  if [[ -z $KUBECTL_PROFILE ]]; then
    :
  else
    echo ' ('$KUBECTL_PROFILE')'
  fi
}

function aws_profile() {
  if [[ -z $AWS_PROFILE ]]; then
    :
  else
    echo ' ('$AWS_PROFILE')'
  fi
}

function urlencode() {
  declare str="$*"
  declare encoded=""
  declare i c x
  for ((i=0; i<${#str}; i++ )); do
    c=${str:$i:1}
    case "$c" in
      [-_.~a-zA-Z0-9] ) x="$c" ;;
      * ) printf -v x '%%%02x' "'$c";;
    esac
    encoded+="$x"
  done
  echo "$encoded"
}

function duck(){
  declare url=$(urlencode "$*")
  lynx --accept_all_cookies "https://duckduckgo.com/lite?q=$url"
}

function wiki_search(){
  declare url=$(urlencode "$*")
  lynx --accept_all_cookies "https://en.wikipedia.org/wiki/$url"
}
