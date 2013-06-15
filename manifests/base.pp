
$node_version = "v0.10.5"

file { '/etc/motd':
	content => "
      .-----.
    .' -   - '.       Ghost Dev VM
   /  .-. .-.  \\      - Version: 1.2 (Casper)
   |  | | | |  |       
    \\ \\o/ \\o/ /       - OS:      Ubuntu precise-server-cloudimg-amd64
   _/    ^    \\_      - Node:    ${node_version}
  | \\  '---'  / |     - IP:      192.168.33.10
  / /`--. .--`\\ \\     - Code:    ~/code/Ghost
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
	node_version => $node_version,
  secure_site => $secure_site,
  user_file_path => $user_file_path,
  user_name => $user_name,
  user_pass => $user_pass
}

