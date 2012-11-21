#!/bin/bash
mv -f ~/.config/chromium/Default/* ~/.config/chromium/Backup/
rm -rf ~/.config/chromium/Default
cp -R ~/.config/chromium/Backup/ ~/.config/chromium/Default/
