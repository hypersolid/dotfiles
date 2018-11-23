run() {
  number=$1
  shift
  for i in `seq $number`; do
    $@
  done
}

random() {
  export random_string=$(openssl rand -base64 32)
  echo $random_string | pbcopy
  echo "$(date) $random_string" >> .random_string
  echo "copied to buffer..."
}

remote_shell() {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo " $(hostname) "
  else
    echo ""
  fi
}
