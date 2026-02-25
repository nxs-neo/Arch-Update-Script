let R = (ansi red_bold)
let G = (ansi green_bold)
let B = (ansi blue_bold)
let Y = (ansi yellow_bold)
let N = (ansi reset)
def __flatpak [ask?: bool] {
	print ""
  print $"($B)Updating Flatpak...($N)"
	print ""
  if $ask {
    ^flatpak update
  } else {
    ^flatpak -y update
  }
}
def __yay [ask?: bool] {
	print ""
  print $"($R)Updating Pacman and AUR...($N)"
	print ""
  if $ask {
    ^yay -Syu
  } else {
    ^yay -Syu --noconfirm
  }
}

def update [
  --ask(-a)
  --yes(-y)
  --shutdown(-s)
  --reboot(-r)
  --help
] {
  if $help {
    print ""
    print "Arch Update Script written by Neo"
    print
    print "OPTIONS: "
    print "default behaviour: run updates for all package managers without asking"
    print "-a or --ask : ask what package managers to update for. "
    print "-h or --help : run this help dialogue"
    print "-s or --shutdown : update and shutdown"
    print "-r or --reboot or --restart : update and reboot"
    print
  }

  if (not $ask) and (not $yes) and (not $shutdown) and (not $reboot) {
    __yay false
    __flatpak false
  }
  if $ask {
    if (input $"($R)Update Pacman? \(y/n\): ($N)") =~ '^(y|Y)' {
      __yay true
    }

    if (input $"($B)Update Flatpak? \(y/n\): ($N)") =~ '^(y|Y)' {
      __flatpak true
    }
    print $"($G)DONE($N)"
  }
  if $shutdown {
    __yay false
    __flatpak false
    ^shutdown now
  }
  if $reboot {
    __yay false
    __flatpak false
    ^reboot
  }
}
