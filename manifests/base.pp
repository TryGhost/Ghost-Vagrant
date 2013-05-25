
$node_version = "v0.10.5"

file { '/etc/motd':
	content => "
      .-----.
    .' -   - '.       Ghost Dev VM
   /  .-. .-.  \\      - Version 1.1 (Casper)
   |  | | | |  |
    \\ \\o/ \\o/ /
   _/    ^    \\_
  | \\  '---'  / |
  / /`--. .--`\\ \\
 / /'---` `---'\\ \\
 '.__.       .__.'
     `|     |`
      |     \\
      \\      '--.
       '.        `\\
         `'---.   |
            ,__) /
             `..'
\n"
}

# Make all the magic happen by instantiating the ghost class
class { ghost:
	node_version => $node_version
}

