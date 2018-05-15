# Start VBoxClient utils if available
if command -v VBoxClient >/dev/null; then
	VBoxClient-all
fi
# Start OpenBox
exec openbox-session
