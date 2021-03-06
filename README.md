This repo contains markup, scripts, and a [Nix](http://nixos.org/nix/) environment used to generate `.txt` and `.html` versions of my resume.

### Why Use an RFC Format for a Resume?

As a software engineer, I come across RFC documents quite often and appreciate their standardized, accessible formatting. At the same time, maintaining a non-text format of my Resume has been arduous. I could use [LaTeX](http://www.latex-project.org/) but despite writing my thesis using it, I've never enjoyed formatting documents with LaTeX.

A specification for writing RFC documents in an extensible markup language (XML) was written in 1999 ([RFC 2629](http://xml2rfc.ietf.org/public/rfc/html/rfc2629.html)) and a tool named [`xml2rfc`](http://xml2rfc.ietf.org/) was made available by the IETF. I thought it would be an interesting experiment to author my resume using this specification.

Throughout the process I've really begun to enjoy the format and find it quite flexible. The ability to output plain-text and html version is also appealing. The specification comes with a surprising amount of flexibility (diagrams, fancy lists, etc.)

### Instructions

Generating my resume requires the [Nix](http://nixos.org/nix/) package manager.

To build:

1. `git clone https://github.com/aaronlevin/resume.git`
2. `cd resume`
3. `nix-shell` (this will put you in a shell with the dependencies required to build my resume artifacts).
4. `./process.sh resume.xml resume`
