$node_version = "v0.10.41"

file { '/etc/motd':
	content => "
      .-----.
    .' -   - '.       Ghost-Vagrant 3.0
   /  .-. .-.  \\
   |  | | | |  |
    \\ \\o/ \\o/ /       - OS:      Ubuntu trusty-server-cloudimg-amd64
   _/    ^    \\_	 - Node:    ${node_version}
  | \\  '---'  / |       - IP:      ${ipaddress_eth1}
  / /`--. .--`\\ \\      - Code:    ~/code/Ghost
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
