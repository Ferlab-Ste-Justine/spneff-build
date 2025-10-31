if command -v nerdctl >/dev/null 2>&1; then
    export COMMAND="nerdctl"
elif command -v docker >/dev/null 2>&1; then
    export COMMAND="docker"
else
    echo "Neither docker nor nerdctl is found in the PATH"
    exit 1;
fi

bash -c "$COMMAND run --rm -v $(pwd):/opt/host -w /opt --entrypoint=\"\" maven:3.9-ibm-semeru-21-noble bash -c '/opt/host/build-container.sh'"