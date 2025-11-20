#! /bin/bash 

if [[ "$1" == "pipewire" ]]; then
  echo "Swtiching to pipewire..."
  systemctl --user stop pulseaudio
  systemctl --user disable pulseaudio
  systemctl --user enable pipewire
  systemctl --user enable wireplumber
  systemctl --user start pipewire
  systemctl --user start wireplumber
  echo "Switched to PipeWire." 
  elif [ "$1" == "pulseaudio" ]; then
    echo "Switching to PulseAudio..."
    systemctl --user stop pipewire
    systemctl --user stop wireplumber
    systemctl --user disable pipewire
    systemctl --user disable wireplumber
    systemctl --user enable pulseaudio
    systemctl --user start pulseaudio
    echo "Switched to PulseAudio."
  else
    echo "Usage: $0 [pipewire|pulseaudio]"
fi
