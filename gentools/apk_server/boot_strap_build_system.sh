if [ -f "melange.rsa" ] && [ -f "melange.rsa.pub" ]; then
    echo "✅ - Keys already exist."
else
    melange keygen > /dev/null 2>&1 \
    && echo "👍 Created Melange keys" \
    || echo "👎 Failure"
fi


