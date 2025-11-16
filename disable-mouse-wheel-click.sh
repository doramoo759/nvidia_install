for id in $(xinput list | grep -i "pointer" | grep -Ei "mouse|receiver|bluetooth" | sed 's/.*id=\([0-9]\+\).*/\1/'); do xinput set-button-map $id 1 0 3 4 5 6 7; done
